<?php

namespace App\Models;

use Core\BaseModel;

use PDO;

class Viatico extends BaseModel {
    public function __construct() {
        parent::__construct('viatico', 'IdVtco');
    }

    public function index() {
        $sql = "SELECT v.*, p.nombre as nombre
                FROM " . $this->table . " v
                INNER JOIN personal p ON v.personal_IdPer = p.IdPer";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getReportData($fechaInicio, $fechaFin) {
        $sql = "SELECT * FROM viatico AS v
                INNER JOIN personal AS p ON v.personal_IdPer = p.IdPer
                INNER JOIN banco AS b ON p.banco_IdBco = b.IdBco
                INNER JOIN condicion_laboral AS cl ON p.condicion_laboral_IdClab = cl.IdClab
                INNER JOIN ley_laboral AS ll ON cl.ley_laboral_IdLlab = ll.IdLlab
                WHERE v.fecha BETWEEN :fechaInicio AND :fechaFin
                ORDER BY v.fecha ASC";

        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':fechaInicio', $fechaInicio);
        $stmt->bindParam(':fechaFin', $fechaFin);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
