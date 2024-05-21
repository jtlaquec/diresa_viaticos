<?php

namespace App\Models;

use Core\BaseModel;

use PDO;

class TipoDocumento extends BaseModel
{
    public function __construct()
    {
        parent::__construct('tipo_documento', 'IdTdoc');
    }
}
