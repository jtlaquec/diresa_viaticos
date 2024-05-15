<?php

namespace App\Controllers;

use Core\Controller;
use App\Models\User;

class LoginController extends Controller {
    private $userModel;

    public function __construct() {
        $this->userModel = new User();
        $this->startSession();
    }

    private function startSession() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }

    public function index() {
        $nombre = 'Login';
        $this->view('auth/login', compact('nombre'),false);
    }


    public function authenticate() {
        $username = $_POST['username'];
        $password = $_POST['password'];
       
        $user = $this->userModel->attempt($username, $password);
        
        if ($user) {
            $_SESSION['IdUser'] = $user['IdUser'];
            $_SESSION['username'] = $user['usuario'];
            $_SESSION['niveles'] = $this->userModel->getNiveles($user['IdUser']);
            return $this->redirect('dashboard');
        } else {
            $error = 'Credenciales inválidas';
            $this->view('auth/login', compact('error'), false);
        }
    }
    
    public function logout() {
        session_start();
        session_destroy();
        $this->redirect('login');
    }
}
