<div>
    <div>
        <div class="text-center">
            <input type="text" id="searchInput" placeholder="Buscar Condición Laboral..." style="width: 600px; border: 2px solid gray; color:black;" autocomplete="off">

            <div class="center py-3">
                <a href="<?php echo BASE_URL; ?>/condicion_laboral/create">
                    <button class="btn btn-secondary">
                        Crear Nueva Condición Laboral
                    </button>
                </a>
            </div>
        </div>
        <table id="viaticosTable" border="5" style="width: 55%;" class="textOrange">
            <thead>
                <tr>
                    <th class="primera_fila center" style="height:50px;">Id</th>
                    <th class="primera_fila center">Condición Laboral</th>
                    <th class="primera_fila center">Ley Laboral</th>
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
                        <td class="segunda_fila center" style="width: 70px;"><?php echo $row["IdClab"]; ?></td>
                        <td class="segunda_fila center" style="width: 400px;"><?php echo $row["condicion_laboral"]; ?></td>
                        <td class="segunda_fila center" style="width: 200px;"><?php echo $row["ley_laboral"]; ?></td>
                        <td class="bot center">
                            <button type="button" onclick="confirmDelete('<?php echo BASE_URL; ?>/condicion_laboral/<?php echo $row['IdClab']; ?>')">Borrar</button>
                        </td>
                        <td class="bot center">
                            <a href="<?php echo BASE_URL; ?>/condicion_laboral/<?php echo $row['IdClab']; ?>/edit">
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