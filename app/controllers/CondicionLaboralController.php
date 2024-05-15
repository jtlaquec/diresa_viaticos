<?php

namespace App\Controllers;

use Core\Controller;
use App\Models\CondicionLaboral;
use App\Models\LeyLaboral;
use PDOException;

class CondicionLaboralController extends Controller {
    protected $model;

    public function __construct() {
        $this->model = new CondicionLaboral();
    }

    public function index() {
        $data = $this->model->index();
        usort($data, function($a, $b) {
            return $b["IdClab"] - $a["IdClab"];
        });
        $nombre = 'Condición Laboral';
        $titulo = 'MANTENIMIENTO: CONDICIÓN LABORAL';
        return $this->view('condicion_laboral/index', compact('data', 'nombre', 'titulo'));
    }

    public function show($id) {
        $data = $this->model->show($id);
        $titulo = 'Detalles del CondicionLaboral';
        return $this->view('condicion_laboral/show', compact('data', 'titulo'));
    }

    public function create() {
        $nombre = 'Condición Laboral';
        $leyes_laborales = new LeyLaboral();
        $leyes_laborales = $leyes_laborales->index();
        $titulo = 'Crear Nueva Condición Laboral';
        return $this->view('condicion_laboral/create', compact('nombre', 'titulo', 'leyes_laborales'));
    }

    public function store() {
        $data = [
            'condicion_laboral' => $_POST['condicion_laboral'],
            'ley_laboral_IdLlab' => $_POST['ley_laboral_IdLlab'],
        ];
        $this->model->create($data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'El viático ha sido creado correctamente.',
        ];

        return $this->redirect('condicion_laboral');
    }

    public function edit($id) {
        $leyes_laborales = new LeyLaboral();
        $leyes_laborales = $leyes_laborales->index();

        $data = $this->model->show($id);
        $nombre = 'Condición Laboral';
        $titulo = 'Editar Viático';
        return $this->view('condicion_laboral/edit', compact('data', 'titulo','nombre', 'leyes_laborales'));
    }

    public function update($id) {
        $data = [
            'condicion_laboral' => $_POST['condicion_laboral'],
            'ley_laboral_IdLlab' => $_POST['ley_laboral_IdLlab'],
        ];
        $this->model->update($id, $data);

        $_SESSION['swal'] = [
            'icon' => 'success',
            'title' => '¡Bien Hecho!',
            'text' => 'La Ley Laboral ha sido actualizada correctamente.',
        ];
        return $this->redirect('condicion_laboral/'.$id.'/edit');
    }

    public function destroy($id) {
        try {
            $this->model->delete($id);
            $_SESSION['swal'] = [
                'icon' => 'success',
                'title' => '¡Bien Hecho!',
                'text' => 'La Condición Laboral ha sido eliminada correctamente.',
            ];
        } catch (PDOException $e) {
            $_SESSION['swal'] = [
                'icon' => 'error',
                'title' => '¡Error!',
                'text' => 'No se pudo eliminar la Condición Laboral: ' . $e->getMessage(),
            ];
        }
        return $this->redirect('condicion_laboral');
    }

    public function reporte() {
        $data = [
            'fecha_inicio' => $_POST['fecha_inicio'],
            'fecha_fin' => $_POST['fecha_fin'],
        ];


        print_r($data);
    }


}
