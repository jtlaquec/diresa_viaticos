<?php
namespace App\Models;

use Core\BaseModel;

use PDO;

class User extends BaseModel {

    public function __construct() {
        parent::__construct('usuario', 'IdUser');
    }

 
    public function attempt($username, $password) {
        $query = "SELECT * FROM {$this->table} WHERE usuario = :username";
        $stmt = $this->db->prepare($query);
        $stmt->bindValue(':username', $username, PDO::PARAM_STR);
        $stmt->execute();
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            return $user;
        }

        return false;
    }

    public function getNiveles($userId) {
        $query = "SELECT n.nivel FROM nivel n 
                  JOIN usuario_nivel un ON n.IdNivel = un.nivel_IdNivel 
                  WHERE un.usuario_IdUser = :userId ORDER BY n.IdNivel";
        $stmt = $this->db->prepare($query);
        $stmt->bindValue(':userId', $userId, PDO::PARAM_INT);
        $stmt->execute();
        $niveles = [];
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $niveles[] = $row['nivel'];
        }
        return $niveles;
    }
}
?>
