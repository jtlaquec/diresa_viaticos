<div style="display: flex; justify-content: center;" class="text-dark">

   
    <form action="<?php echo BASE_URL; ?>/viaticos/<?php echo $data['IdVtco']; ?>" method="POST" style="width: 40%; background-color: #f8f9fa; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">


        <input type="hidden" name="_method" value="PUT">
        <div class="form-group py-2">
            <label for="numero_viatico" class="fw-bold py-2">Número de viático</label>
            <input type="number" id="numero_viatico" name="numero_viatico" class="form-control" required placeholder="Ingrese el número de viático" value="<?php echo $data['numero_viatico']; ?>">
        </div>

        <div class="form-group py-2">
            <label for="fecha" class="fw-bold py-2">Fecha</label>
            <input type="date" id="fecha" name="fecha" class="form-control" required value="<?php echo $data['fecha']; ?>">
        </div>

        <div class="form-group py-2">
            <label for="monto" class="fw-bold py-2">Monto</label>
            <input type="number" id="monto" name="monto" class="form-control" required placeholder="Ingrese el monto" value="<?php echo $data['monto']; ?>">
        </div>

        <div class="form-group py-2">
            <label for="siaf" class="fw-bold py-2">N° Siaf</label>
            <input type="number" id="siaf" name="siaf" class="form-control" required placeholder="Ingrese el número SIAF" value="<?php echo $data['siaf']; ?>">
        </div>

        <div class="form-group py-2">
            <label for="personal_IdPer" class="fw-bold py-2">Empleado</label>
            <select class="js-example-basic-single form-control py-2" name="personal_IdPer" required>
                <option value="" disabled>Seleccione al empleado</option>
                <?php
                if (!empty($empleados)) {
                    foreach ($empleados as $empleado) {
                        $selected = ($empleado['IdPer'] == $data['personal_IdPer']) ? 'selected' : '';
                        echo '<option value="' . htmlspecialchars($empleado['IdPer']) . '" ' . $selected . '>' . htmlspecialchars($empleado['nombre']) . '</option>';
                    }
                } else {
                    echo '<option>No hay empleados disponibles</option>';
                }
                ?>
            </select>
        </div>

        <div class="d-flex justify-content-center py-3">
            <button type="submit" class="btn btn-primary">Actualizar Viático</button>
        </div>
    </form>


    
</div>

<a href="<?php echo BASE_URL; ?>/viaticos" style="position: fixed; bottom: 20px; left: 20px;">
    <button type="button" class="btn btn-secondary">Volver</button>
</a>

<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    $(document).ready(function() {
        $('.js-example-basic-single').select2({
            placeholder: "Seleccione al empleado",
            allowClear: true
        });
    });
</script>