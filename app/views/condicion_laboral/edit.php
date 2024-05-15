<div style="display: flex; justify-content: center;" class="text-dark">

    <form action="<?php echo BASE_URL; ?>/condicion_laboral/<?php echo $data['IdClab']; ?>" method="POST" style="width: 40%; background-color: #f8f9fa; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">

        <input type="hidden" name="_method" value="PUT">
        <div class="form-group py-2">
            <label for="condicion_laboral" class="fw-bold py-2">Condición Laboral</label>
            <input type="text" id="condicion_laboral" name="condicion_laboral" class="form-control" required placeholder="Ingrese la Condición Laboral" value="<?php echo $data['condicion_laboral']; ?>">
        </div>

        <div class="form-group py-2">
            <label for="ley_laboral_IdLlab" class="fw-bold py-2">Ley Laboral</label>
            <select class="js-example-basic-single form-control  py-2" name="ley_laboral_IdLlab" required>
                <option value="" disabled selected>Seleccione al empleado</option>

                <?php
                if (!empty($leyes_laborales)) {
                    foreach ($leyes_laborales as $ley_laboral) {
                        $selected = ($ley_laboral['IdLlab'] == $data['ley_laboral_IdLlab']) ? 'selected' : '';
                        echo '<option value="' . htmlspecialchars($ley_laboral['IdLlab']) . '" ' . $selected . '>' . htmlspecialchars($ley_laboral['ley_laboral']) . '</option>';
                    }
                } else {
                    echo '<option>No hay Leyes Laborales disponibles</option>';
                }
                ?>

            </select>
        </div>

        <div class="d-flex justify-content-center py-3">
            <button type="submit" class="btn btn-primary">Crear Nueva Condición Laboral</button>
        </div>

    </form>
</div>

<a href="<?php echo BASE_URL; ?>/condicion_laboral" style="position: fixed; bottom: 20px; left: 20px;">
    <button type="button" class="btn btn-secondary"> Volver
    </button>
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