<?php

namespace App\Models;

use Core\BaseModel;

use PDO;

class Permiso extends BaseModel
{
    public function __construct()
    {
        parent::__construct('usuario_nivel', 'IdUserNivel');
    }

    public function index()
    {
        $sql = "SELECT * FROM {$this->table} as un
                INNER JOIN usuario as u ON un.usuario_IdUser = u.IdUser
                INNER JOIN nivel as n ON un.nivel_IdNivel = n.IdNivel";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
