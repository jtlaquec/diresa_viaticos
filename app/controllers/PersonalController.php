<?php

namespace App\Controllers;

use PDOException;
use Core\Controller;
use App\Models\Banco;
use App\Models\Personal;
use App\Models\CondicionLaboral;
use App\Models\PDFPersonal;

class PersonalController extends Controller
{
    protected $model;

    public function __construct()
    {
        $this->model = new Personal();
    }

    public function index()
    {
        $data = $this->model->index();
        usort($data, function ($a, $b) {
            return $b["IdPer"] - $a["IdPer"];
        });

        $condiciones_laborales = new CondicionLaboral();
        $condiciones_laborales = $condiciones_laborales->index();

        $nombre = 'Empleados';
        $titulo = 'Listado de Empleados';
        return $this->view('empleados/index', compact('data', 'titulo', 'nombre','condiciones_laborales'));
    }

    public function show($id)
    {
        $data = $this->model->show($id);
        $titulo = 'Detalles del Personal';
        return $this->view('empleados/show', compact('data', 'titulo'));
    }

    public function create()
    {
        $titulo = 'Crear Nuevo Personal';
        $bancos = new Banco();
        $condiciones_laborales = new CondicionLaboral();

        $bancos = $bancos->index();
        $condiciones_laborales = $condiciones_laborales->index();
        return $this->view('empleados/create', compact('titulo', 'bancos', 'condiciones_laborales'));
    }

    public function store()
    {

        $dni = $_POST['dni'];

        if ($this->model->dniExiste($dni)) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'El DNI ya existe. Por favor, ingrese un DNI único.',
            ];
            return $this->redirect('empleados/create');
        }
        $data = [
            'dni' => $_POST['dni'],
            'condicion_laboral_IdClab' => $_POST['condicion_laboral_IdClab'],
            'nombre' => $_POST['nombre'],
            'banco_IdBco' => $_POST['banco_IdBco'],
            'ctacte' => $_POST['ctacte'],
        ];
        $this->model->create($data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El empleado ha sido creado correctamente.',
        ];

        return $this->redirect('empleados');
    }

    public function edit($id)
    {
        $data = $this->model->show($id);
        $titulo = 'Editar Personal';

        $bancos = new Banco();
        $condiciones_laborales = new CondicionLaboral();

        $bancos = $bancos->index();
        $condiciones_laborales = $condiciones_laborales->index();


        return $this->view('empleados/edit', compact('data', 'titulo', 'bancos', 'condiciones_laborales'));
    }

    public function update($id)
    {
        $originalData = $this->model->show($id);
        $dniOriginal = $originalData['dni'];

        $nuevoDNI = $_POST['dni'];

        if ($nuevoDNI != $dniOriginal && $this->model->dniExiste($nuevoDNI)) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'El DNI ya existe. Por favor, ingrese un DNI único.',
            ];
            return $this->redirect('empleados/' . $id . '/edit');
        }

        $data = [
            'dni' => $_POST['dni'],
            'condicion_laboral_IdClab' => $_POST['condicion_laboral_IdClab'],
            'nombre' => $_POST['nombre'],
            'banco_IdBco' => $_POST['banco_IdBco'],
            'ctacte' => $_POST['ctacte'],
        ];
        $this->model->update($id, $data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El empleado ha sido actualizado correctamente.',
        ];

        return $this->redirect('empleados');
    }

    public function destroy($id)
    {
        try {
            $this->model->delete($id);
            $_SESSION['swal'] = [
                'icon' => 'success',
                'title' => '¡Bien Hecho!',
                'text' => 'El empleado ha sido eliminado correctamente.',
            ];
        } catch (PDOException $e) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'No se pudo borrar el empleado: ' . $e->getMessage(),
            ];
        }
        return $this->redirect('empleados');
    }

    public function reporte()
    {
        if (isset($_POST['condicion_laboral_IdClab'])) {
            $resultado = $this->model->datosReporte($_POST['condicion_laboral_IdClab']);
            $pdf = new PDFPersonal();
            $pdf->AliasNbPages();
            $pdf->AddPage();
        
            foreach ($resultado as $row) {
                $pdf -> SetFont("Arial","", 8);
                $pdf -> Cell(10, 5, $row['IdPer'], 1, 0, "C");
                $pdf -> Cell(90, 5, utf8_decode($row['nombre']), 1, 0, "L");
                $pdf -> Cell(40, 5, $row['condicion_laboral'], 1, 0, "C");
                $pdf -> Cell(30, 5, $row['ley_laboral'], 1, 0, "C");
                $pdf -> Cell(60, 5, utf8_decode($row['banco']), 1, 0, "L");
                $pdf -> Cell(40, 5, $row['ctacte'], 1, 0, "C");
                $pdf->Ln();
            }
        
            $pdf->Output('I', 'Reporte_Personal.pdf');
        } else {
            echo "No proporciono Condición Laboral";
        }

    }
}
