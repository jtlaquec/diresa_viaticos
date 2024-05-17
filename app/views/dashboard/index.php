<div>

    <div class="container mt-5 text-dark">


        <div class="d-flex justify-content-around">
            <div class="card bg-light mb-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h1 class="card-title center"><?php echo $empleados; ?></h1>
                    <p class="card-text center">Empleados Registrados</p>
                </div>
            </div>
            <div class="card bg-light mb-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h1 class="card-title center"><?php echo $viaticos; ?></h1>
                    <p class="card-text center">Viáticos Registrados</p>
                </div>
            </div>

            <div class="card bg-light mb-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h1 class="card-title center">Bancos</h1>
                    <p class="card-text center">
                    <ul>
                        <?php
                        if (!empty($bancos)) {
                            foreach ($bancos as $banco) {
                                echo '<li>' . htmlspecialchars($banco['banco']) . '</li>';
                            }
                        } else {
                            echo ' <li>No hay bancos disponibles</li>';
                        }
                        ?>
                    </ul>

                    </p>
                </div>
            </div>

            <div class="card bg-light mb-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h1 class="card-title center">Condiciones Laborales</h1>
                    <p class="card-text center">
                    <ul>
                        <?php
                        if (!empty($condiciones_laborales)) {
                            foreach ($condiciones_laborales as $condicion_laboral) {
                                echo '<li>' . htmlspecialchars($condicion_laboral['condicion_laboral']) . '</li>';
                            }
                        } else {
                            echo ' <li>No hay Condiciones Laborales disponibles</li>';
                        }
                        ?>
                    </ul>

                    </p>
                </div>
            </div>
        </div>






    </div>





</div>