<div>
    <div>
        <div class="text-center">
            <input type="text" id="searchInput" placeholder="Buscar Permisos..." style="width: 600px; border: 2px solid gray; color:black;" autocomplete="off">

            <div class="center py-3">
                <a href="<?php echo BASE_URL; ?>/permisos/create">
                    <button class="btn btn-secondary">
                        Asignar Nuevo Permiso
                    </button>
                </a>
            </div>
        </div>
        <table id="empleadosTable" border="5" style="width: 45%;" class="textOrange">
            <thead>
                <tr>
                    <th class="primera_fila center" style="height:50px;">Id</th>
                    <th class="primera_fila center">Usuario</th>
                    <th class="primera_fila center">Nivel</th>
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
                        <td class="segunda_fila center" style="width: 50px;"><?php echo $row["IdUserNivel"]; ?></td>
                        <td class="segunda_fila center" style="width: 200px;"><?php echo $row["usuario"]; ?></td>
                        <td class="segunda_fila center" style="width: 200px;"><?php echo $row["nivel"]; ?></td>
                        <td class="bot center">
                            <button type="button" onclick="confirmDelete('<?php echo BASE_URL; ?>/permisos/<?php echo $row['IdUserNivel']; ?>')">Borrar</button>
                        </td>
                        <td class="bot center">
                            <a href="<?php echo BASE_URL; ?>/permisos/<?php echo $row['IdUserNivel']; ?>/edit">
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
                <h5 class="modal-title text-dark fw-bold" id="exampleModalLabel">Reporte de Viáticos</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <form action="<?php echo BASE_URL; ?>/permisos/reportes" method="POST" autocomplete="off">

                    <div>
                        <label class="text-dark py-4 fw-bold">Fecha Inicial:</label>
                        <input type="date" name="fecha_inicio" id="fecha_inicio" value="<?php echo date('Y-m-d'); ?>" required>
                    </div>

                    <div>
                        <label class="text-dark fw-bold">Fecha Final:</label>
                        <input type="date" name="fecha_fin" id="fecha_fin" value="<?php echo date('Y-m-d'); ?>" required>
                    </div>
            </div>
            <div class="modal-footer">
                <!--         <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button> -->
                <button type="submit" class="btn btn-primary ">Generar Reporte (PDF)</button>
            </div>
            </form>
        </div>
    </div>

</div>