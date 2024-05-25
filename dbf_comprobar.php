<?php
if (!extension_loaded('dbase')) {
    die("La extensión dbase no está habilitada.");
}

$file_path = 'prueba.dbf';

$dbf = dbase_open($file_path, 0);

if (!$dbf) {
    die("Error al abrir la base de datos DBF.");
}

// Obtenemos el número de registros y campos
$num_records = dbase_numrecords($dbf);
$num_fields = dbase_numfields($dbf);

// Obtenemos la estructura de los campos
$fields_info = dbase_get_header_info($dbf);

// Mostramos la estructura de los campos
echo "<h2>Estructura de los Campos</h2>";
echo "<table border='1'>";
echo "<tr><th>Nombre</th><th>Tipo</th><th>Longitud</th><th>Decimales</th></tr>";
foreach ($fields_info as $field) {
    echo "<tr>";
    echo "<td>{$field['name']}</td>";
    echo "<td>{$field['type']}</td>";
    echo "<td>{$field['length']}</td>";
    echo "<td>{$field['precision']}</td>";
    echo "</tr>";
}
echo "</table>";

// Mostramos los registros
echo "<h2>Registros</h2>";
echo "<table border='1'>";
echo "<tr>";
foreach ($fields_info as $field) {
    echo "<th>{$field['name']}</th>";
}
echo "</tr>";

for ($i = 1; $i <= $num_records; $i++) {
    $record = dbase_get_record_with_names($dbf, $i);
    echo "<tr>";
    foreach ($record as $key => $value) {
        if ($key != 'deleted') {
            echo "<td>{$value}</td>";
        }
    }
    echo "</tr>";
}
echo "</table>";

dbase_close($dbf);
?>
