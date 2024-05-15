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
        $sql = "SELECT * FROM " . $this->table . " as p
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
}
