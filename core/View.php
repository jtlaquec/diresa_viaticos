<?php

namespace Core;

class View {
    public function render($view, $data = []) {
        $viewPath = '../app/views/' . $view . '.php';
        if (file_exists($viewPath)) {
            require_once $viewPath;
        } else {
            die("View does not exist.");
        }
    }
}
