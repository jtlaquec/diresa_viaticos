<div style="display: flex; justify-content: center;" class="text-dark">
   
<form action="<?php echo BASE_URL; ?>/bancos/<?php echo $data['IdBco']; ?>" method="POST" style="width: 40%; background-color: #f8f9fa; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
    <input type="hidden" name="_method" value="PUT">
    <div class="form-group py-2">
            <label for="banco" class="fw-bold py-2">Banco</label>
            <input type="text" id="banco" name="banco" class="form-control" required placeholder="Ingrese el nombre del Banco" value="<?php echo $data['banco']; ?>">
        </div>

        <div class="form-group py-2">
            <label for="avr" class="fw-bold py-2">AVR</label>
            <input type="text" id="avr" name="avr" class="form-control" required placeholder="Ingrese el avr del Banco" value="<?php echo $data['avr']; ?>">
        </div>

        <div class="d-flex justify-content-center py-3">
            <button type="submit" class="btn btn-primary">Actualizar Banco</button>
        </div>

    </form>
</div>

<a href="<?php echo BASE_URL; ?>/bancos" style="position: fixed; bottom: 20px; left: 20px;">
    <button type="button" class="btn btn-secondary"> Volver
    </button>
</a>
