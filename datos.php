<?php

// Configuración de la conexión a la base de datos
$host = 'localhost';
$dbname = 'rrhh';
$username = 'root';
$password = '';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $stmt = $conn->prepare("INSERT INTO viatico (numero_viatico, fecha, monto, siaf, personal_IdPer) VALUES (:numero_viatico, :fecha, :monto, :siaf, :personal_IdPer)");

    for ($i = 1; $i <= 20; $i++) {
        $numero_viatico = 'V-' . str_pad($i, 4, '0', STR_PAD_LEFT);
        $fecha = date('Y-m-d', strtotime("-" . rand(0, 365) . " days"));
        $monto = rand(100, 10000);
        $siaf = rand(1000, 9999);
        $personal_IdPer = rand(1, 20);

        $stmt->bindParam(':numero_viatico', $numero_viatico);
        $stmt->bindParam(':fecha', $fecha);
        $stmt->bindParam(':monto', $monto);
        $stmt->bindParam(':siaf', $siaf);
        $stmt->bindParam(':personal_IdPer', $personal_IdPer);

        $stmt->execute();
    }

    echo "20 registros insertados con éxito.";
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
