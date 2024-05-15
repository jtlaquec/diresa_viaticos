<?php

namespace App\Controllers;

use Core\Controller;
use App\Models\Viatico;
use App\Models\Personal;
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
        $data = [
            'numero_viatico' => $_POST['numero_viatico'],
            'fecha' => $_POST['fecha'],
            'monto' => $_POST['monto'],
            'siaf' => $_POST['siaf'],
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
        $data = [
            'numero_viatico' => $_POST['numero_viatico'],
            'fecha' => $_POST['fecha'],
            'monto' => $_POST['monto'],
            'siaf' => $_POST['siaf'],
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

}
