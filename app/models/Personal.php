<?php

namespace App\Models;

use Core\BaseModel;

use PDO;

class Personal extends BaseModel
{
    public function __construct()
    {
        parent::__construct('personal', 'IdPer');
    }

    public function index()
    {
        $sql = "SELECT * FROM {$this->table} as p
        INNER JOIN banco as b ON p.banco_IdBco = b.IdBco
        INNER JOIN condicion_laboral as cl ON p.condicion_laboral_IdClab = cl.IdClab";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function reporte($username)
    {
        $stmt = $this->db->prepare("SELECT * FROM {$this->table} WHERE usuario = :username");
        $stmt->bindParam(':username', $username);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function datosReporte($condicion_laboral_IdClab) {
        $sql = "SELECT * FROM {$this->table} AS per
        INNER JOIN condicion_laboral AS cl  ON per.condicion_laboral_IdClab=cl.IdClab 
        INNER JOIN ley_laboral       AS ll  ON cl.ley_laboral_IdLlab=ll.IdLlab
        INNER JOIN banco             AS bco ON per.banco_IdBco=bco.IdBco  
        WHERE per.condicion_laboral_IdClab=:condicion_laboral_IdClab
        ORDER BY per.condicion_laboral_IdClab, per.nombre";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':condicion_laboral_IdClab', $condicion_laboral_IdClab);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function dniExiste($dni) {
        $sql = "SELECT COUNT(*) FROM {$this->table} WHERE dni = :dni";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':dni', $dni, PDO::PARAM_STR);
        $stmt->execute();
        $count = $stmt->fetchColumn();
        return $count > 0;
    }
}
