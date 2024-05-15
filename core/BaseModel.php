<?php

namespace Core;

use PDO;

class BaseModel extends Model {
    protected $table;
    protected $primaryKey;

    public function __construct($table, $primaryKey = 'id') {
        parent::__construct();
        $this->table = $table;
        $this->primaryKey = $primaryKey;
    }

    public function index() {
        $stmt = $this->db->prepare("SELECT * FROM {$this->table}");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function show($id) {
        $stmt = $this->db->prepare("SELECT * FROM {$this->table} WHERE {$this->primaryKey} = :id");
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function create($data) {
        $keys = array_keys($data);
        $fields = implode(', ', $keys);
        $placeholders = ':' . implode(', :', $keys);

        $stmt = $this->db->prepare("INSERT INTO {$this->table} ($fields) VALUES ($placeholders)");

        foreach ($data as $key => $value) {
            $stmt->bindValue(":$key", $value);
        }

        return $stmt->execute();
    }

    public function update($id, $data) {
        $fields = '';
        foreach ($data as $key => $value) {
            $fields .= "$key = :$key, ";
        }
        $fields = rtrim($fields, ', ');

        $stmt = $this->db->prepare("UPDATE {$this->table} SET $fields WHERE {$this->primaryKey} = :id");
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);

        foreach ($data as $key => $value) {
            $stmt->bindValue(":$key", $value);
        }

        return $stmt->execute();
    }

    public function delete($id) {
        $stmt = $this->db->prepare("DELETE FROM {$this->table} WHERE {$this->primaryKey} = :id");
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }
}
