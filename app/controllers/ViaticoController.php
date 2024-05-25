<?php

namespace App\Controllers;

use Core\Controller;
use App\Models\Viatico;
use App\Models\Personal;
use App\Models\PDFViaticos;
use App\Models\TxtViaticos;
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

    //Exportacion anterior en texto
    public function exportarTexto()
    {
        if (isset($_POST['numero_viatico'])) {
    
            $numeroViatico = $_POST['numero_viatico'];
            $reportData = $this->model->datosExportacion($numeroViatico);
            $txtContent = '';
    
            if (empty($reportData)) {
                header('Content-Type: text/plain');
                echo "No hay registros en las fechas ingresadas.";
            } else {

                //$txtContent .= "ctacte,monto,IdTdoc,dni\n";
                
                foreach ($reportData as $row) {
                    $txtContent .= $row['ctacte'] . ',' . $row['monto'] . ',' . $row['IdTdoc'] . ',' . $row['dni'] . "\n";
                }
    
            $fileName = "Reporte_Viatico_" . $numeroViatico . ".txt";

            header('Content-Type: text/plain');
            header('Content-Disposition: attachment; filename="' . $fileName . '"');
            header('Content-Length: ' . strlen($txtContent));
            echo $txtContent;
            }
    
        } else {
            echo "Número de Viático no Proporcionado";
        }
    }

    public function exportar()
    {
        if (isset($_POST['numero_viatico'])) {
    
            $numeroViatico = $_POST['numero_viatico'];
            $reportData = $this->model->datosExportacion($numeroViatico);
    
            if (empty($reportData)) {
                header('Content-Type: text/plain');
                echo "No hay registros en las fechas ingresadas.";
            } else {
                // Definimos la estructura de la tabla DBF
                $columns = [
                    ['NUM_CTA', 'C', 20],   // Número de cuenta, tipo CHAR, longitud 20
                    ['TIPO_DOC', 'C', 2],   // Tipo de documento, tipo CHAR, longitud 2
                    ['NUM_DOC', 'C', 20],   // Número de documento, tipo CHAR, longitud 20
                    ['MONTO', 'N', 19, 2],  // Monto, tipo NUMERIC, longitud 19, 2 decimales
                    ['ESTADO', 'C', 1]      // Estado, tipo CHAR, longitud 1
                ];
    
                // Crear la base de datos DBF
                $fileName = "V_" . $numeroViatico . ".dbf";
                $dbf = dbase_create($fileName, $columns);
    
                if (!$dbf) {
                    die("Error al crear la base de datos DBF.");
                }

                // Insertamos los datos
                foreach ($reportData as $row) {
                    $record = [
                        $row['ctacte'],
                        $row['IdTdoc'],
                        $row['dni'],
                        $row['monto'],
                        'I'
                    ];
                    if (!dbase_add_record($dbf, $record)) {
                        echo "Error al agregar el registro: " . implode(', ', $record) . "\n";
                    }
                }
    
                dbase_close($dbf);
    
                header('Content-Type: application/octet-stream');
                header('Content-Disposition: attachment; filename="' . $fileName . '"');
                header('Content-Length: ' . filesize($fileName));
                readfile($fileName);

                unlink($fileName);
            }
    
        } else {
            echo "Número de Viático no Proporcionado";
        }
    }
    
    
}
