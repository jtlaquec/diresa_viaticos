<?php

namespace App\Models;

use Core\BaseModel;

class Banco extends BaseModel {
    public function __construct() {
        parent::__construct('banco', 'IdBco');
    }
}
