<?php

namespace App\Controllers;

use Core\Controller;

use App\Models\Personal;
use App\Models\Viatico;
use App\Models\Banco;
use App\Models\CondicionLaboral;
class DashboardController extends Controller {



    public function index() {
        $nombre = 'Dashboard';
        $titulo = 'Bienvenido, '.($_SESSION['username']);
        $empleados = new Personal();
        $empleados = count($empleados->index());

        $viaticos = new Viatico();
        $viaticos = count($viaticos->index());

        $bancos = new Banco();
        $bancos = $bancos->index();

        $condiciones_laborales = new CondicionLaboral();
        $condiciones_laborales = $condiciones_laborales->index();

        return $this->view('dashboard/index', compact('nombre', 'titulo','empleados','viaticos','bancos','condiciones_laborales'),true);
    }
}
