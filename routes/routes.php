<?php

function resource($name, $controller, $auth = true) {
    return [
        'GET' => [
            $name => ['controller' => $controller, 'method' => 'index', 'auth' => $auth],
            "$name/create" => ['controller' => $controller, 'method' => 'create', 'auth' => $auth],
            "$name/{id}" => ['controller' => $controller, 'method' => 'show', 'auth' => $auth],
            "$name/{id}/edit" => ['controller' => $controller, 'method' => 'edit', 'auth' => $auth],
            "$name/reportes" => ['controller' => $controller, 'method' => 'mostrarReporte', 'auth' => $auth],
            "$name/exportar" => ['controller' => $controller, 'method' => 'mostrarExportacion', 'auth' => $auth],
        ],
        'POST' => [
            $name => ['controller' => $controller, 'method' => 'store', 'auth' => $auth],
            "$name/reportes" => ['controller' => $controller, 'method' => 'reporte', 'auth' => $auth],
            "$name/exportar" => ['controller' => $controller, 'method' => 'exportar', 'auth' => $auth],
        ],
        'PUT' => [
            "$name/{id}" => ['controller' => $controller, 'method' => 'update', 'auth' => $auth],
        ],
        'DELETE' => [
            "$name/{id}" => ['controller' => $controller, 'method' => 'destroy', 'auth' => $auth],
        ],
    ];
}

$routes = array_merge_recursive(
    [
        // Rutas específicas
        'GET' => [
            '' => ['controller' => 'DashboardController', 'method' => 'index', 'auth' => true],
            'dashboard' => ['controller' => 'DashboardController', 'method' => 'index', 'auth' => true],
            'login' => ['controller' => 'LoginController', 'method' => 'index', 'auth' => false],
        ],
        'POST' => [
            'login' => ['controller' => 'LoginController', 'method' => 'authenticate', 'auth' => false],
            'logout' => ['controller' => 'LoginController', 'method' => 'logout', 'auth' => true],
        ],
    ],
    resource('viaticos', 'ViaticoController'),
    resource('personal', 'PersonalController'),
    resource('empleados', 'PersonalController'),
    resource('bancos', 'BancoController'),
    resource('condicion_laboral', 'CondicionLaboralController'),
    resource('ley_laboral', 'LeyLaboralController'),
    resource('usuarios', 'UsuarioController'),
    resource('niveles', 'NivelController'),
    resource('permisos', 'PermisoController'),
);

return $routes;
