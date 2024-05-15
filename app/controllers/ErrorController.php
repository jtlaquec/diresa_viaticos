<?php

namespace App\Controllers;

use Core\Controller;

class ErrorController extends Controller {
    public function index() {
        $title = 'Error 404';
        $this->view('errores/404', compact('title'), false);
    }
}
