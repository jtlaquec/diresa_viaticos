<?php

namespace Core;

class App {
    protected $defaultController = 'App\\Controllers\\DashboardController';
    protected $defaultMethod = 'index';
    protected $controller;
    protected $method;
    protected $params = [];
    protected $authRequired = true;

    public function __construct() {
        $this->startSession();
        $url = $this->parseUrl();
        $routes = $this->loadRoutes();
        $httpMethod = $this->detectHttpMethod();

        // Si la URL está vacía o contiene solo una cadena vacía, redirigir al controlador por defecto
        if ($this->isRootUrl($url)) {
            $this->setupDefaultRoute();
        } else {
            $this->setupRouteFromUrl($url, $routes, $httpMethod);
        }

        // Verificar autenticación si es requerida
        if ($this->authRequired && !isset($_SESSION['IdUser'])) {
            $this->redirectToLogin();
        }

        // Instanciar el controlador y llamar al método
        if ($this->instantiateController()) {
            $this->callControllerMethod();
        } else {
            $this->loadErrorController();
        }
    }

    // Iniciar sesión si no está ya iniciada
    private function startSession() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }

    // Parsear la URL en segmentos
    private function parseUrl() {
        if (isset($_GET['url'])) {
            return explode('/', filter_var(rtrim($_GET['url'], '/'), FILTER_SANITIZE_URL));
        }
        return [''];
    }

    // Detectar el método HTTP
    private function detectHttpMethod() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['_method'])) {
            return strtoupper($_POST['_method']);
        }
        return $_SERVER['REQUEST_METHOD'];
    }

    // Cargar las rutas desde un archivo de configuración
    private function loadRoutes() {
        return include '../routes/routes.php';
    }

    // Obtener la clave de la ruta a partir de la URL
    private function getRouteKey($url) {
        return preg_replace('/\d+/', '{id}', implode('/', $url));
    }

    // Extraer los parámetros de la URL
    private function extractParams($url, $routeKey) {
        $routeParts = explode('/', $routeKey);
        $urlParts = explode('/', implode('/', $url));
        $params = [];
        foreach ($routeParts as $key => $part) {
            if ($part === '{id}' && isset($urlParts[$key])) {
                $params[] = $urlParts[$key];
            }
        }
        return $params;
    }

    // Instanciar el controlador
    private function instantiateController() {
        if (is_string($this->controller) && class_exists($this->controller)) {
            $this->controller = new $this->controller;
            return true;
        }
        return false;
    }

    // Llamar al método del controlador
    private function callControllerMethod() {
        if (method_exists($this->controller, $this->method)) {
            call_user_func_array([$this->controller, $this->method], $this->params);
        } else {
            $this->loadErrorController();
        }
    }

    // Cargar el controlador de error
    private function loadErrorController() {
        static $errorLoaded = false;
        if ($errorLoaded) {
            return;
        }
        $errorLoaded = true;

        require_once '../app/controllers/ErrorController.php';
        $this->controller = 'App\\Controllers\\ErrorController';
        if (class_exists($this->controller)) {
            $this->controller = new $this->controller;
            $this->controller->index();
        } else {
            echo "ErrorController no encontrado";
        }
    }

    // Verificar si la URL es la raíz
    private function isRootUrl($url) {
        return empty($url) || (count($url) === 1 && $url[0] === '');
    }

    // Configurar la ruta por defecto
    private function setupDefaultRoute() {
        $this->controller = $this->defaultController;
        $this->method = $this->defaultMethod;
        $this->authRequired = true;
    }

    // Configurar la ruta a partir de la URL
    private function setupRouteFromUrl($url, $routes, $httpMethod) {
        $routeKey = $this->getRouteKey($url);
        if (isset($routes[$httpMethod][$routeKey])) {
            $route = $routes[$httpMethod][$routeKey];
            $this->controller = 'App\\Controllers\\' . $route['controller'];
            $this->method = $route['method'];
            $this->authRequired = $route['auth'];
            $this->params = $this->extractParams($url, $routeKey);
        } else {
            $this->loadErrorController();
        }
    }

    // Redirigir al controlador de login
    private function redirectToLogin() {
        $this->controller = 'App\\Controllers\\LoginController';
        $this->method = 'index';
    }
}
