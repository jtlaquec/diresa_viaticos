<?php

namespace App\Models;

use Core\BaseModel;

class LeyLaboral extends BaseModel {
    public function __construct() {
        parent::__construct('ley_laboral', 'IdLlab');
    }
}
