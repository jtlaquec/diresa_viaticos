<?php
if (!function_exists('menuNiveles')) {
    function menuNiveles($nivel) {
        $nivelCarpeta = strtolower(str_replace(" ", "_", $nivel));
        $nivelCarpeta = htmlspecialchars($nivelCarpeta);
        echo "<li class=\"nav-item\">";
        echo "<a class=\"nav-link\" href=".BASE_URL."/$nivelCarpeta\>" . htmlspecialchars($nivel) . "</a>";
        echo "</li>";
    }
}
?>

<header>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="<?php echo BASE_URL;?>">Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <?php
                if (isset($_SESSION['niveles'])) {
                    foreach ($_SESSION['niveles'] as $nivel) {
                        menuNiveles($nivel);
                    }
                }
                ?>
            </ul>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <form action="<?php echo BASE_URL?>/logout" method="post" id="logout-form">
                        <button type="submit" class="nav-link btn btn-link" style="text-decoration: none;">Cerrar Sesión</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>
</header>
