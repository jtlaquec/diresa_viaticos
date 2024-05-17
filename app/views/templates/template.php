<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo $nombre ?? 'Mi Aplicación'; ?></title>
  <link rel="icon" href="<?php echo BASE_URL; ?>/images/logo.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="<?php echo BASE_URL; ?>/css/hoja1.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />


</head>

<body>
  <?php include '../app/views/partials/navbar.php'; ?>
  <div>
    <hr class="text-secondary">
    <h1 class="text-dark">
      <div align="center">
        <?php echo $titulo; ?>
      </div>
    </h1>
    <hr class="text-secondary">
  </div>
  <main>
    <?php echo $content; ?>
  </main>

  <?php include '../app/views/partials/footer.php'; ?>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

  <script>
    $(document).ready(function() {
      <?php if (isset($_SESSION['swal'])) : ?>
        Swal.fire(<?php echo json_encode($_SESSION['swal']); ?>);
        <?php unset($_SESSION['swal']); ?>
      <?php endif; ?>

      const rowsPerPage = 20;
      const maxPageLinks = 15;
      let currentPage = 1;
      let allRows = $('#tableBody tr');

      function displayRows() {
        let searchQuery = $('#searchInput').val().toLowerCase();
        let filteredRows = allRows.filter(function() {
          let rowText = $(this).text().toLowerCase();
          return rowText.includes(searchQuery);
        });

        let totalRows = filteredRows.length;
        let totalPages = Math.ceil(totalRows / rowsPerPage);
        let start = (currentPage - 1) * rowsPerPage;
        let end = start + rowsPerPage;

        $('#tableBody').html(filteredRows.slice(start, end));
        updatePagination(totalPages);
      }

      function updatePagination(totalPages) {
        $('#pagination').empty();

        if (totalPages <= 1) return;

        const firstPage = `<span class="first-page ${currentPage === 1 ? 'disabled' : ''}">Primera</span>`;
        const prevPage = `<span class="prev-page ${currentPage === 1 ? 'disabled' : ''}">Anterior</span>`;
        const nextPage = `<span class="next-page ${currentPage === totalPages ? 'disabled' : ''}">Siguiente</span>`;
        const lastPage = `<span class="last-page ${currentPage === totalPages ? 'disabled' : ''}">Última</span>`;

        $('#pagination').append(firstPage, prevPage);

        let startPage = Math.max(currentPage - Math.floor(maxPageLinks / 2), 1);
        let endPage = startPage + maxPageLinks - 1;

        if (endPage > totalPages) {
          endPage = totalPages;
          startPage = Math.max(endPage - maxPageLinks + 1, 1);
        }

        for (let i = startPage; i <= endPage; i++) {
          let pageLink = $(`<span>`).text(i).addClass(i === currentPage ? 'active' : '');
          pageLink.on('click', function(e) {
            e.preventDefault();
            currentPage = i;
            displayRows();
          });
          $('#pagination').append(pageLink);
        }

        $('#pagination').append(nextPage, lastPage);

        $('.first-page').on('click', function(e) {
          e.preventDefault();
          if (currentPage > 1) {
            currentPage = 1;
            displayRows();
          }
        });

        $('.prev-page').on('click', function(e) {
          e.preventDefault();
          if (currentPage > 1) {
            currentPage--;
            displayRows();
          }
        });

        $('.next-page').on('click', function(e) {
          e.preventDefault();
          if (currentPage < totalPages) {
            currentPage++;
            displayRows();
          }
        });

        $('.last-page').on('click', function(e) {
          e.preventDefault();
          if (currentPage < totalPages) {
            currentPage = totalPages;
            displayRows();
          }
        });
      }

      $('#searchInput').on('keyup', function() {
        currentPage = 1;
        displayRows();
      });

      displayRows();
    });

    function confirmDelete(url) {
      Swal.fire({
        title: "¿Estás seguro?",
        text: "¡No podrás revertir esto!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "¡Sí, eliminalo!",
        cancelButtonText: "Cancelar"
      }).then((result) => {
        if (result.isConfirmed) {
          const form = document.getElementById('delete-form');
          form.action = url;
          form.submit();
        }
      });
    }

    $(document).ready(function() {
      $('.js-example-basic-single').select2({
        placeholder: "Seleccione un campo",
        allowClear: true
      });
    });
  </script>
</body>

</html>