<?php

namespace App\Controllers;

use Core\Controller;

class DashboardController extends Controller {



    public function index() {
        $nombre = 'Dashboard';
        $titulo = 'Panel Administrativo';
        return $this->view('dashboard/index', compact('nombre', 'titulo'),true);
    }
}
