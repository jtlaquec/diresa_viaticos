<?php

namespace App\Models;

use PDO;
use Core\BaseModel;

class CondicionLaboral extends BaseModel
{
    public function __construct()
    {
        parent::__construct('condicion_laboral', 'IdClab');
    }

    public function index()
    {
        $sql = "SELECT * FROM  {$this->table} as cl
        INNER JOIN ley_laboral as ll ON cl.ley_laboral_IdLlab = ll.IdLlab";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
