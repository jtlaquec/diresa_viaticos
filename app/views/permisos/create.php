<div style="display: flex; justify-content: center;" class="text-dark">
    <form action="<?php echo BASE_URL; ?>/permisos" method="POST" style="width: 40%; background-color: #f8f9fa; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">


        <div class="form-group py-2">
            <label for="usuario_IdUser" class="fw-bold py-2">Usuario</label>
            <select class="js-example-basic-single form-control  py-2" name="usuario_IdUser" required>
                <option value="" disabled selected>Seleccione al empleado</option>
                <?php
                if (!empty($empleados)) {
                    foreach ($empleados as $empleado) {
                        echo '<option value="' . htmlspecialchars($empleado['IdUser']) . '">' . htmlspecialchars($empleado['usuario']) . '</option>';
                    }
                } else {
                    echo '<option>No hay empleados disponibles</option>';
                }
                ?>
            </select>
        </div>

        <div class="form-group py-2">
            <label for="nivel_IdNivel" class="fw-bold py-2">Nivel</label>
            <select class="js-example-basic-single form-control  py-2" name="nivel_IdNivel" required>
                <option value="" disabled selected>Seleccione un nivel</option>
                <?php
                if (!empty($niveles)) {
                    foreach ($niveles as $nivel) {
                        echo '<option value="' . htmlspecialchars($nivel['IdNivel']) . '">' . htmlspecialchars($nivel['nivel']) . '</option>';
                    }
                } else {
                    echo '<option>No hay niveles disponibles</option>';
                }
                ?>
            </select>
        </div>

        <div class="d-flex justify-content-center py-3">
            <button type="submit" class="btn btn-primary">Crear Nuevo Viático</button>
        </div>

    </form>
</div>

<a href="<?php echo BASE_URL; ?>/permisos" style="position: fixed; bottom: 20px; left: 20px;">
    <button type="button" class="btn btn-secondary"> Volver
    </button>
</a>