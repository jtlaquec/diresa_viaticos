<div>


    <div class="container mt-5 text-dark">
        <h1>Bienvenido <?php echo htmlspecialchars($_SESSION['username']); ?></h1>
        <p>Seleccione un nivel del menú para gestionar.</p>

        <hr>
        <p>Niveles de acceso (Prueba)</p>
        <?php
        print_r($_SESSION['niveles']);
        ?>
    </div>





</div>