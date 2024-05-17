-- Deshabilitar safe mode en workbench
UPDATE personal
SET dni = CASE
	WHEN CHAR_LENGTH(dni) = 6 THEN CONCAT('00', dni)
	WHEN CHAR_LENGTH(dni) = 7 THEN CONCAT('0', dni)
	ELSE dni
END