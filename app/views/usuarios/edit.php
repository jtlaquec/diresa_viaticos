<div style="display: flex; justify-content: center;" class="text-dark">

    <form action="<?php echo BASE_URL; ?>/usuarios/<?php echo $data['IdUser']; ?>" method="POST" style="width: 40%; background-color: #f8f9fa; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
        <input type="hidden" name="_method" value="PUT">
        <div class="form-group py-2">
            <label for="usuario" class="fw-bold py-2">Usuario</label>
            <input type="text" id="usuario" name="usuario" class="form-control" required placeholder="Ingrese el nombre del Usuario" value="<?php echo $data['usuario']; ?>">
        </div>

        <div class="form-group py-2">
            <label for="password" class="fw-bold py-2">Contraseña</label>
            <input type="text" id="password" name="password" class="form-control" required placeholder="Ingrese la contraseña del Usuario">
        </div>

        <div class="d-flex justify-content-center py-3">
            <button type="submit" class="btn btn-primary">Crear Nuevo Usuario</button>
        </div>

    </form>
</div>

<a href="<?php echo BASE_URL; ?>/usuarios" style="position: fixed; bottom: 20px; left: 20px;">
    <button type="button" class="btn btn-secondary"> Volver
    </button>
</a>