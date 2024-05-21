<div style="display: flex; justify-content: center;" class="text-dark">
    <form action="<?php echo BASE_URL; ?>/empleados" method="POST" style="width: 40%; background-color: #f8f9fa; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">

        <div class="form-group py-2">
            <label for="tipo_documento_IdTdoc" class="fw-bold py-2">Tipo de Documento</label>
            <select class="js-example-basic-single form-control  py-2" name="tipo_documento_IdTdoc" required>
                <option value="" disabled selected>Seleccione un tipo de documento</option>
                <?php
                if (!empty($tipos_documentos)) {
                    foreach ($tipos_documentos as $tipo_documento) {
                        echo '<option value="' . htmlspecialchars($tipo_documento['IdTdoc']) . '">' . htmlspecialchars($tipo_documento['tip_doc']) . '</option>';
                    }
                } else {
                    echo '<option>No hay Tipos de Documentos disponibles</option>';
                }
                ?>
            </select>
        </div>

        <div class="form-group py-2">
            <label for="dni" class="fw-bold py-2">DNI</label>
            <input type="number" id="dni" name="dni" class="form-control" required placeholder="Ingrese el número de DNI">
        </div>

        <div class="form-group py-2">
            <label for="condicion_laboral_IdClab" class="fw-bold py-2">Condición Laboral</label>
            <select class="js-example-basic-single form-control  py-2" name="condicion_laboral_IdClab" required>
                <option value="" disabled selected>Seleccione al empleado</option>
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



        <div class="form-group py-2">
            <label for="nombre" class="fw-bold py-2">Nombre</label>
            <input type="text" id="nombre" name="nombre" class="form-control" required placeholder="Ingrese el nombre del empleado">
        </div>

        <div class="form-group py-2">
            <label for="banco_IdBco" class="fw-bold py-2">Banco</label>
            <select class="js-example-basic-single form-control  py-2" name="banco_IdBco" required>
                <option value="" disabled selected>Seleccione un banco</option>
                <?php
                if (!empty($bancos)) {
                    foreach ($bancos as $banco) {
                        echo '<option value="' . htmlspecialchars($banco['IdBco']) . '">' . htmlspecialchars($banco['banco']) . '</option>';
                    }
                } else {
                    echo '<option>No hay Bancos disponibles</option>';
                }
                ?>
            </select>
        </div>

        <div class="form-group py-2">
            <label for="ctacte" class="fw-bold py-2">Cuenta Corriente</label>
            <input type="number" id="ctacte" name="ctacte" class="form-control" required placeholder="Ingrese la Cuenta Corriente">
        </div>

        <div class="d-flex justify-content-center py-3">
            <button type="submit" class="btn btn-primary">Crear Nuevo Empleado</button>
        </div>

    </form>
</div>

<a href="<?php echo BASE_URL; ?>/empleados" style="position: fixed; bottom: 20px; left: 20px;">
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