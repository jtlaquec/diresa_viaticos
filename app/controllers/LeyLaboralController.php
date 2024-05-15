<?php

namespace App\Controllers;

use Core\Controller;
use App\Models\LeyLaboral;
use PDOException;

class LeyLaboralController extends Controller {
    protected $model;

    public function __construct() {
        $this->model = new LeyLaboral();
    }

    public function index() {
        $data = $this->model->index();
        $nombre = 'Leyes Laborales';
        $titulo = 'MANTENIMIENTO: LEYES LABORALES';
        return $this->view('ley_laboral/index', compact('data', 'nombre', 'titulo'));
    }

    public function show($id) {
        $data = $this->model->show($id);
        $titulo = 'Detalles de la Ley Laboral';
        return $this->view('ley_laboral/show', compact('data', 'titulo'));
    }

    public function create() {
        $nombre = 'Leyes Laborales';
        $titulo = 'Crear Nueva Ley Laboral';
        return $this->view('ley_laboral/create', compact('nombre', 'titulo'));
    }

    public function store() {
        $data = [
            'ley_laboral' => $_POST['ley_laboral'],
        ];
        $this->model->create($data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'La Ley Laboral ha sido creada correctamente.',
        ];

        return $this->redirect('ley_laboral');
    }

    public function edit($id) {

        $data = $this->model->show($id);
        $nombre = 'Leyes Laborales';
        $titulo = 'Editar Ley Laboral';
        return $this->view('ley_laboral/edit', compact('data', 'titulo','nombre'));
    }

    public function update($id) {
        $data = [
            'ley_laboral' => $_POST['ley_laboral'],
        ];
        $this->model->update($id, $data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'La Ley Laboral ha sido actualizada correctamente.',
        ];
        return $this->redirect('ley_laboral/'.$id.'/edit');
    }

    public function destroy($id) {
        try {
            $this->model->delete($id);
            $_SESSION['swal'] = [
                'icon' => 'success',
                'title' => '¡Bien Hecho!',
                'text' => 'La Ley Laboral ha sido eliminada correctamente.',
            ];
        } catch (PDOException $e) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'No se pudo eliminar la Ley Laboral: ' . $e->getMessage(),
            ];
        }
        return $this->redirect('ley_laboral');
    }

    public function reporte() {
        $data = [
            'fecha_inicio' => $_POST['fecha_inicio'],
            'fecha_fin' => $_POST['fecha_fin'],
        ];


        print_r($data);
    }


}
