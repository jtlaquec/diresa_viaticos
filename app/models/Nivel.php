<?php

namespace App\Models;

use Core\BaseModel;

use PDO;

class Nivel extends BaseModel
{
    public function __construct()
    {
        parent::__construct('nivel', 'IdNivel');
    }

}