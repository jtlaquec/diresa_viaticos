<?php

namespace App\Controllers;

use Core\Controller;
use App\Models\User;
use App\Models\Personal;
use PDOException;

class UsuarioController extends Controller {
    protected $model;

    public function __construct() {
        $this->model = new User();
    }

    public function index() {
        $data = $this->model->index();
        $nombre = 'Usuarios';
        $titulo = 'MANTENIMIENTO: USUARIO';
        return $this->view('usuarios/index', compact('data', 'nombre', 'titulo'));
    }

    public function show($id) {
        $data = $this->model->show($id);
        $titulo = 'Detalles del Usuario';
        return $this->view('usuarios/show', compact('data', 'titulo'));
    }

    public function create() {
        $nombre = 'Usuarios';
        $titulo = 'Crear Nuevo Usuario';
        return $this->view('usuarios/create', compact('nombre', 'titulo'));
    }

    public function store() {
        $data = [
            'usuario' => $_POST['usuario'],
            'password' => password_hash($_POST['password'],PASSWORD_DEFAULT),
        ];
        $this->model->create($data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El usuario ha sido creado correctamente.',
        ];

        return $this->redirect('usuarios');
    }

    public function edit($id) {
        $data = $this->model->show($id);
        $nombre = 'Usuarios';
        $titulo = 'Editar Usuario';
        return $this->view('usuarios/edit', compact('data', 'titulo','nombre'));
    }

    public function update($id) {
        $data = [
            'usuario' => $_POST['usuario'],
            'password' => password_hash($_POST['password'],PASSWORD_DEFAULT),
        ];
        $this->model->update($id, $data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El usuario ha sido actualizado correctamente.',
        ];
        return $this->redirect('usuarios/'.$id.'/edit');
    }

    public function destroy($id) {
        try {
            $this->model->delete($id);
            $_SESSION['swal'] = [
                'icon' => 'success',
                'title' => '¡Bien Hecho!',
                'text' => 'El usuario ha sido eliminado correctamente.',
            ];
        } catch (PDOException $e) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'No se pudo borrar el usuario: ' . $e->getMessage(),
            ];
        }
        return $this->redirect('usuarios');
    }

    public function reporte() {
        $data = [
            'fecha_inicio' => $_POST['fecha_inicio'],
            'fecha_fin' => $_POST['fecha_fin'],
        ];


        print_r($data);
    }


}
