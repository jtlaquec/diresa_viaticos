<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title><?php echo $nombre ?? 'Mi Aplicación'; ?></title>
</head>

<body>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card" style="width: 30rem;">
            <div class="card-body">
                <div class="py-3">
                    <img src="<?php echo BASE_URL; ?>/images/dashboard.png" alt="Dashboard" style="height: 200px;" class="mx-auto d-block">
                </div>

                <h5 class="card-title text-center">Sistema de Viáticos</h5>
                <form action="<?php echo BASE_URL ?>/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Usuario:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Ingresar</button>
                </form>
                <h4 class="text-red center">

                    <?php echo $error ?? ''; ?>

                </h4>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>