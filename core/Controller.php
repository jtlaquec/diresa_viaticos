<?php

namespace Core;

class Controller {
    public function model($model) {
        $modelClass = 'App\\Models\\' . $model;
        return new $modelClass();
    }

    public function view($view, $data = [], $useTemplate = true, $baseView = 'template') {
        $content = $this->renderView($view, $data);

        if ($useTemplate) {
            $data['content'] = $content; // Asegúrate de pasar el contenido renderizado
            extract($data);
            if (is_string($useTemplate)) {
                require_once "../app/views/templates/{$useTemplate}.php";
            } else {
                require_once "../app/views/templates/{$baseView}.php";
            }
        } else {
            echo $content;
        }
    }

    private function renderView($view, $data) {
        extract($data);
        ob_start();
        require "../app/views/{$view}.php";
        return ob_get_clean();
    }

    public function redirect($url) {
        header('Location: ' . BASE_URL . '/' . $url);
        exit;
    }
}
