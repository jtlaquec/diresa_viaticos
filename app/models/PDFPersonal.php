<?php

namespace App\Models;

require_once(BASE_PATH . '/libraries/fpdf/fpdf.php');
use FPDF;

class PDFPersonal extends FPDF
{
    protected $fechaReporte;

    public function __construct($fechaInicio = null, $fechaFin = null, $orientation = 'L', $unit = 'mm', $size = 'A4')
    {
        parent::__construct($orientation, $unit, $size);
        $this->fechaReporte = 'Del ' . date('d/m/Y', strtotime($fechaInicio)) . ' al ' . date('d/m/Y', strtotime($fechaFin));
    }

    public function obtenerFecha()
    {
        return date('d/m/Y');
    }

    function Header()
    {
        /* $this->Cell(25); */
        $this->SetFont('Arial', '', 8);
        $this->Cell(0, 5, ('O.I.T.E-NODO51'), 0, 1, 'C');
        $this->SetFont('Arial', 'B', 10);
        $this->Cell(0, 5, utf8_decode('REPORTE: PERSONAL - CONDICIÓN LABORAL'), 0, 1, 'C');
        $this->Cell(0, 5, utf8_decode('DIRECCIÓN REGIONAL DE SALUD TACNA'), 0, 1, 'C');

        date_default_timezone_set("America/Lima");

        $this->SetFont('Arial', '', 8);
        $this->Cell(0, 5, utf8_decode("Al ") . $this->obtenerFecha(), 0, 1, 'C');
        $this->Ln(03);
        $this->SetFont("Arial", "B", 8);
        $this->Cell(10, 5, 'ID', 1, 0, "C");
        $this->Cell(90, 5, 'APELLIDOS Y NOMBRES', 1, 0, "C");
        $this->Cell(40, 5, utf8_decode('CONDICIÓN LABORAL'), 1, 0, "C");
        $this->Cell(30, 5, 'LEY LABORAL', 1, 0, "C");
        $this->Cell(60, 5, 'BANCO', 1, 0, "C");
        $this->Cell(40, 5, 'CTA. CTE.', 1, 0, 'C');
        $this->Ln();
    }

    function Footer()
    {
        $this->SetY(-15);
        $this->SetFont('Arial', 'I', 8);
        $this->Cell(0, 10, 'Pagina ' . $this->PageNo() . '/{nb}', 0, 0, 'C');
    }
}
