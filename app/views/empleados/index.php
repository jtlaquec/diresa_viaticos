<div>
    <div>
        <div class="text-center">
            <input type="text" id="searchInput" placeholder="Buscar Empleados..." style="width: 600px; border: 2px solid gray; color:black;" autocomplete="off">

            <div class="center py-3">
                <a href="<?php echo BASE_URL; ?>/empleados/create">
                    <button class="btn btn-secondary">
                        Crear Nuevo Empleado
                    </button>
                </a>
            </div>
        </div>
        <table id="empleadosTable" border="5" style="width: 90%;" class="textOrange">
            <thead>
                <tr>
                    <th class="primera_fila center" style="height:50px;">Id</th>
                    <th class="primera_fila center">DNI</th>
                    <th class="primera_fila center">C. Laboral</th>
                    <th class="primera_fila center">Nombre</th>
                    <th class="primera_fila center">Banco</th>
                    <th class="primera_fila center">Cta. Cte</th>
                    <th class="primera_fila center" colspan="2">
                        <div align="center">
                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">Reporte</button>
                            <a href="<?php echo BASE_URL; ?>">
                                <button type="button">Salir</button>
                            </a>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody id="tableBody">
                <?php foreach ($data as $row) : ?>
                    <tr>
                        <td class="segunda_fila center" style="width: 50px;"><?php echo $row["IdPer"]; ?></td>
                        <td class="segunda_fila center" style="width: 90px;"><?php echo $row["dni"]; ?></td>
                        <td class="segunda_fila center" style="width: 251px;"><?php echo $row["condicion_laboral"]; ?></td>
                        <td class="segunda_fila center" style="width: 400px;"><?php echo $row["nombre"]; ?></td>
                        <td class="segunda_fila center" style="width: 300px;"><?php echo $row["banco"]; ?></td>
                        <td class="segunda_fila center" style="width: 200px;"><?php echo $row["ctacte"]; ?></td>
                        <td class="bot center">
                            <button type="button" onclick="confirmDelete('<?php echo BASE_URL; ?>/empleados/<?php echo $row['IdPer']; ?>')">Borrar</button>
                        </td>
                        <td class="bot center">
                            <a href="<?php echo BASE_URL; ?>/empleados/<?php echo $row['IdPer']; ?>/edit">
                                <button type="button">Actualizar</button>
                            </a>
                        </td>
                    </tr>
                <?php endforeach; ?>

            </tbody>

        </table>

    </div>

</div>
<div class="pagination py-4" id="pagination"></div>
<form id="delete-form" action="" method="POST" style="display: none;">
    <input type="hidden" name="_method" value="DELETE">
</form>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-dark fw-bold" id="exampleModalLabel">Reporte de Personal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <form action="<?php echo BASE_URL; ?>/empleados/reportes" method="POST" autocomplete="off" target="_blank">

                    <div class="form-group py-2">
                        <div>
                        <label for="condicion_laboral_IdClab" class="fw-bold py-2">Seleccione una Condición Laboral</label>
                        </div>
                        <select class="py-2" name="condicion_laboral_IdClab" required>

                            <?php
                            if (!empty($condiciones_laborales)) {
                                foreach ($condiciones_laborales as $condicion_laboral) {
                                    echo '<option value="' . htmlspecialchars($condicion_laboral['IdClab']) . '">' . htmlspecialchars($condicion_laboral['condicion_laboral']) . '</option>';
                                }
                            } else {
                                echo '<option>No hay Condiciones Laborales disponibles</option>';
                            }
                            ?>
                        </select>
                    </div>

            </div>
            <div class="modal-footer">

                <button type="submit" class="btn btn-primary ">Generar Reporte (PDF)</button>
            </div>
            </form>
        </div>
    </div>
</div>