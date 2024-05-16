<?php

namespace App\Models;

require_once(BASE_PATH . '/libraries/fpdf/fpdf.php');
use FPDF;

class PDFViaticos extends FPDF
{
    protected $fechaReporte;

    public function __construct($fechaInicio = null, $fechaFin = null, $orientation = 'L', $unit = 'mm', $size = 'A4')
    {
        parent::__construct($orientation, $unit, $size);
        $this->fechaReporte = 'Del ' . date('d/m/Y', strtotime($fechaInicio)) . ' al ' . date('d/m/Y', strtotime($fechaFin));
    }

    function Header()
    {
        /* $this->Cell(25); */
        $this->SetFont('Arial', '', 8);
        $this->Cell(0,5,('O.I.T.E-NODO51'),0,1,'C');
        $this->SetFont('Arial', 'B', 10);
        $this->Cell(0, 5, utf8_decode('REPORTE: VIÁTICOS'), 0, 1, 'C');
        $this->Cell(0, 5, utf8_decode('DIRECCIÓN REGIONAL DE SALUD TACNA'), 0, 1, 'C');

        date_default_timezone_set("America/Lima");
       
        $this->SetFont('Arial', '', 8);
        $this->Cell(0, 5,  utf8_decode("Período: ") . $this->fechaReporte, 0, 1, 'C');

        $this->Ln(03);
        $this->SetFont("Arial", "B", 8);
        $this->Cell(10, 10, 'ID', 1, 0, 'C');
        $this->Cell(15, 10, utf8_decode('NÚMERO'), 1, 0, 'C');
        $this->Cell(20, 10, 'FECHA', 1, 0, 'C');
        $this->Cell(20, 10, 'MONTO', 1, 0, 'C');
        $this->Cell(20, 10, utf8_decode('N° SIAF'), 1, 0, 'C');
        $this->Cell(75, 10, 'PERSONAL', 1, 0, 'C');
		$this->Cell(30, 10, 'CONDICION', 1, 0, 'C');
		$this->Cell(30, 10, 'LEY', 1, 0, 'C');
		$this->Cell(30, 10, 'BANCO', 1, 0, 'C');
		$this->Cell(30, 10, 'CUENTA CTE.', 1, 0, 'C');
        $this->Ln();
    }

    function Footer()
    {
        $this->SetY(-15);
        $this->SetFont('Arial', 'I', 8);
        $this->Cell(0, 10, 'Pagina ' . $this->PageNo() . '/{nb}', 0, 0, 'C');
    }
}

