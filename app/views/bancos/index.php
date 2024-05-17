<div>
    <div>
        <div class="text-center">

        <div>
                <input class="px-2 py-1 rounded" type="text" id="searchInput" placeholder="Buscar Bancos..." style="width: 600px; border: 2px solid gray; color:black;" autocomplete="off">
            </div>
      
            <div class="center py-3">
                <a href="<?php echo BASE_URL; ?>/bancos/create">
                    <button class="btn btn-secondary">
                        Crear Nuevo Banco
                    </button>
                </a>
            </div>
        </div>
        <table id="empleadosTable" border="5" style="width: 60%;" class="textOrange">
            <thead>
                <tr>
                    <th class="primera_fila center" style="height:50px;">Id</th>
                    <th class="primera_fila center">Entidad Financiera</th>
                    <th class="primera_fila center">AVR</th>
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
                        <td class="segunda_fila center" style="width: 100px;"><?php echo $row["IdBco"]; ?></td>
                        <td class="segunda_fila center" style="width: 500px;"><?php echo $row["banco"]; ?></td>
                        <td class="segunda_fila center" style="width: 100px;"><?php echo $row["avr"]; ?></td>
                        <td class="bot center">
                            <button type="button" onclick="confirmDelete('<?php echo BASE_URL; ?>/bancos/<?php echo $row['IdBco']; ?>')">Borrar</button>
                        </td>
                        <td class="bot center">
                            <a href="<?php echo BASE_URL; ?>/bancos/<?php echo $row['IdBco']; ?>/edit">
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