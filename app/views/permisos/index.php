<div>
    <div>
        <div class="text-center">

            <div>
                <input class="px-2 py-1 rounded" type="text" id="searchInput" placeholder="Buscar Permisos..." style="width: 600px; border: 2px solid gray; color:black;" autocomplete="off">
            </div>

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
                            <!-- <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">Reporte</button> -->
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