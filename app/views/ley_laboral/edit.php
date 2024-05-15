<div style="display: flex; justify-content: center;" class="text-dark">

    <form action="<?php echo BASE_URL; ?>/ley_laboral/<?php echo $data['IdLlab']; ?>" method="POST" style="width: 40%; background-color: #f8f9fa; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
        <input type="hidden" name="_method" value="PUT">
        <div class="form-group py-2">
            <label for="ley_laboral" class="fw-bold py-2">Ley Laboral</label>
            <input type="text" id="ley_laboral" name="ley_laboral" class="form-control" required placeholder="Ingrese la ley Laboral" value="<?php echo $data['ley_laboral']; ?>">
        </div>

        <div class="d-flex justify-content-center py-3">
            <button type="submit" class="btn btn-primary">Crear Nueva Ley Laboral</button>
        </div>

    </form>
</div>

<a href="<?php echo BASE_URL; ?>/ley_laboral" style="position: fixed; bottom: 20px; left: 20px;">
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