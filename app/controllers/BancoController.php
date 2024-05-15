<?php

namespace App\Controllers;

use PDOException;
use Core\Controller;
use App\Models\Banco;

class BancoController extends Controller {
    protected $model;

    public function __construct() {
        $this->model = new Banco();
    }

    public function index() {
        $data = $this->model->index();
        $nombre = 'Bancos';
        $titulo = 'MANTENIMIENTO: BANCOS';
        // Para no usar ninguna plantilla usar false
        $this->view('bancos/index', compact('data', 'nombre', 'titulo'), true);
    }

    public function show($id) {
        $data = $this->model->show($id);
        $titulo = 'Detalles del Banco';
        $this->view('bancos/show', compact('data', 'titulo'));
    }

    public function create() {
        $titulo = 'Crear Nuevo Banco';
        $this->view('bancos/create', compact('titulo'));
    }

    public function store() {
        $data = [
            'banco' => $_POST['banco'],
            'avr' => $_POST['avr'],
        ];
        $this->model->create($data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El banco ha sido creado correctamente.',
        ];

        return $this->redirect('bancos');
    }

    public function edit($id) {
        $data = $this->model->show($id);
        $titulo = 'Editar Banco';
        $this->view('bancos/edit', compact('data', 'titulo'));
    }

    public function update($id) {
        $data = [
            'banco' => $_POST['banco'],
            'avr' => $_POST['avr'],
        ];
        $this->model->update($id, $data);
        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El banco ha sido actualizado correctamente.',
        ];
        return $this->redirect('bancos');
    }

    public function destroy($id) {
        try {
            $this->model->delete($id);
            $_SESSION['swal'] = [
                'icon' => 'success',
                'title' => '¡Bien Hecho!',
                'text' => 'El banco ha sido eliminado correctamente.',
            ];
        } catch (PDOException $e) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'No se pudo borrar el banco: ' . $e->getMessage(),
            ];
        }
        return $this->redirect('bancos');
    }
}
