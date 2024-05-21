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

    public function datosReporte($fechaInicio, $fechaFin) {
        $sql = "SELECT * FROM {$this->table} AS v
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

    public function datosExportacion($fechaInicio, $fechaFin) {
        $sql = "SELECT * FROM {$this->table} AS v
                INNER JOIN personal AS p ON v.personal_IdPer = p.IdPer
                INNER JOIN tipo_documento AS tp ON p.tipo_documento_IdTdoc = tp.IdTdoc
                WHERE v.fecha BETWEEN :fechaInicio AND :fechaFin
                ORDER BY v.fecha ASC";

        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':fechaInicio', $fechaInicio);
        $stmt->bindParam(':fechaFin', $fechaFin);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function siafExiste($siaf) {
        $sql = "SELECT COUNT(*) FROM {$this->table} WHERE siaf = :siaf";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':siaf', $siaf, PDO::PARAM_STR);
        $stmt->execute();
        $count = $stmt->fetchColumn();
        return $count > 0;
    }
}
