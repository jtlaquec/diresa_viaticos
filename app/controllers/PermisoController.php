<?php

namespace App\Controllers;

use Core\Controller;
use App\Models\Permiso;
use App\Models\Nivel;
use App\Models\User;
use PDOException;

class PermisoController extends Controller {
    protected $model;

    public function __construct() {
        $this->model = new Permiso();
    }

    public function index() {
        $data = $this->model->index();
        usort($data, function($a, $b) {
            return $b["IdUserNivel"] - $a["IdUserNivel"];
        });
        $nombre = 'Viáticos';
        $titulo = 'MANTENIMIENTO: PERMISOS';
        return $this->view('permisos/index', compact('data', 'nombre', 'titulo'));
    }

    public function show($id) {
        $data = $this->model->show($id);
        $titulo = 'Detalles del Permiso';
        return $this->view('permisos/show', compact('data', 'titulo'));
    }

    public function create() {
        $nombre = 'Permisos';
        $niveles = new Nivel();
        $niveles = $niveles->index();

        $empleados = new User();
        $empleados = $empleados->index();

        $titulo = 'Crear Nuevo Permiso';
        return $this->view('permisos/create', compact('nombre', 'titulo', 'niveles','empleados'));
    }

    public function store() {
        $data = [
            'usuario_IdUser' => $_POST['usuario_IdUser'],
            'nivel_IdNivel' => $_POST['nivel_IdNivel'],
        ];
        $this->model->create($data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El permiso ha sido creado correctamente.',
        ];

        return $this->redirect('permisos');
    }

    public function edit($id) {

        $niveles = new Nivel();
        $niveles = $niveles->index();

        $empleados = new User();
        $empleados = $empleados->index();


        $data = $this->model->show($id);
        $nombre = 'Permisos';
        $titulo = 'Editar Permiso';
        return $this->view('permisos/edit', compact('data', 'titulo','nombre', 'empleados','niveles'));
    }

    public function update($id) {
        $data = [
            'usuario_IdUser' => $_POST['usuario_IdUser'],
            'nivel_IdNivel' => $_POST['nivel_IdNivel'],
        ];
        $this->model->update($id, $data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El permiso ha sido actualizado correctamente.',
        ];
        return $this->redirect('permisos/'.$id.'/edit');
    }

    public function destroy($id) {
        try {
            $this->model->delete($id);
            $_SESSION['swal'] = [
                'icon' => 'success',
                'title' => '¡Bien Hecho!',
                'text' => 'El permiso ha sido eliminado correctamente.',
            ];
        } catch (PDOException $e) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'No se pudo borrar el permiso: ' . $e->getMessage(),
            ];
        }
        return $this->redirect('permisos');
    }

    public function reporte() {
        $data = [
            'fecha_inicio' => $_POST['fecha_inicio'],
            'fecha_fin' => $_POST['fecha_fin'],
        ];


        print_r($data);
    }


}
