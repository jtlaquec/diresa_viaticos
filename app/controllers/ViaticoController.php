<?php

namespace App\Controllers;

use Core\Controller;
use App\Models\Viatico;
use App\Models\Personal;
use App\Models\PDFViaticos;
use PDOException;

class ViaticoController extends Controller
{
    protected $model;

    public function __construct()
    {
        $this->model = new Viatico();
    }

    public function index()
    {
        $data = $this->model->index();
        usort($data, function ($a, $b) {
            return $b["IdVtco"] - $a["IdVtco"];
        });
        $nombre = 'Viáticos';
        $titulo = 'MANTENIMIENTO: VIÁTICOS';
        return $this->view('viaticos/index', compact('data', 'nombre', 'titulo'));
    }

    public function show($id)
    {
        $data = $this->model->show($id);
        $titulo = 'Detalles del Viatico';
        return $this->view('viaticos/show', compact('data', 'titulo'));
    }

    public function create()
    {
        $nombre = 'Viáticos';
        $empleados = new Personal();
        $empleados = $empleados->index();
        $titulo = 'Crear Nuevo Viatico';
        return $this->view('viaticos/create', compact('nombre', 'titulo', 'empleados'));
    }

    public function store()
    {
        $siaf = $_POST['siaf'];

        if ($this->model->SiafExiste($siaf)) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'El SIAF ya existe. Por favor, ingrese un SIAF único.',
            ];
            return $this->redirect('viaticos/create');
        }

        $data = [
            'numero_viatico' => $_POST['numero_viatico'],
            'fecha' => $_POST['fecha'],
            'monto' => $_POST['monto'],
            'siaf' => $siaf,
            'personal_IdPer' => $_POST['personal_IdPer'],
        ];
        $this->model->create($data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El viático ha sido creado correctamente.',
        ];

        return $this->redirect('viaticos');
    }


    public function edit($id)
    {
        $personal = new Personal();
        $empleados = $personal->index();
        $data = $this->model->show($id);
        $nombre = 'Viáticos';
        $titulo = 'Editar Viático';
        return $this->view('viaticos/edit', compact('data', 'titulo', 'nombre', 'empleados'));
    }

    public function update($id)
    {
        $originalData = $this->model->show($id);
        $siafOriginal = $originalData['siaf'];

        $nuevoSiaf = $_POST['siaf'];

        if ($nuevoSiaf != $siafOriginal && $this->model->siafExiste($nuevoSiaf)) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'El SIAF ya existe. Por favor, ingrese un SIAF único.',
            ];
            return $this->redirect('viaticos/' . $id . '/edit');
        }

        $data = [
            'numero_viatico' => $_POST['numero_viatico'],
            'fecha' => $_POST['fecha'],
            'monto' => $_POST['monto'],
            'siaf' => $nuevoSiaf,
            'personal_IdPer' => $_POST['personal_IdPer'],
        ];
        $this->model->update($id, $data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El viático ha sido actualizado correctamente.',
        ];
        return $this->redirect('viaticos/' . $id . '/edit');
    }

    public function destroy($id)
    {
        try {
            $this->model->delete($id);
            $_SESSION['swal'] = [
                'icon' => 'success',
                'title' => '¡Bien Hecho!',
                'text' => 'El viático ha sido eliminado correctamente.',
            ];
        } catch (PDOException $e) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'No se pudo borrar el viático: ' . $e->getMessage(),
            ];
        }
        return $this->redirect('viaticos');
    }

    public function reporte()
    {
        if (isset($_POST['fecha_inicio']) && isset($_POST['fecha_fin'])) {

            $fechaInicio = $_POST['fecha_inicio'];
            $fechaFin = $_POST['fecha_fin'];
            $reportData = $this->model->datosReporte($fechaInicio, $fechaFin);
            $pdf = new PDFViaticos($fechaInicio, $fechaFin);
            $pdf->AliasNbPages();
            $pdf->AddPage();

            foreach ($reportData as $row) {
                $pdf->SetFont('Arial', '', 8);
                $pdf->Cell(10, 10, $row['IdVtco'], 1, 0, "C");
                $pdf->Cell(15, 10, $row['numero_viatico'], 1, 0, "C");
                $pdf->Cell(20, 10, $row['fecha'], 1, 0, "C");
                $pdf->Cell(20, 10, number_format($row['monto'], 2), 1, 0, "C");
                $pdf->Cell(20, 10, $row['siaf'], 1, 0, "C");
                $pdf->Cell(75, 10, utf8_decode($row['nombre']), 1, 0, "C");
                $pdf->Cell(30, 10, $row['condicion_laboral'], 1, 0, "C");
                $pdf->Cell(30, 10, $row['ley_laboral'], 1, 0, "C");
                $pdf->Cell(30, 10, $row['avr'], 1, 0, "C");
                $pdf->Cell(30, 10, $row['ctacte'], 1, 0, "C");
                $pdf->Ln();
            }

            $pdf->Output('I', 'Reporte_Viaticos.pdf');
        } else {
            echo "Fechas no proporcionadas";
        }
    }
}
