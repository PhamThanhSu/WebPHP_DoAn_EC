<?php
array_push($cssStack, '<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">');
array_push($cssStack, '<link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">');
array_push($cssStack, '<link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">');
array_push($cssStack, '<link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">');
array_push($cssStack, '<link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">');
array_push($cssStack, '<link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">');
array_push($cssStack, '<link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">');


array_push($jsStack, '
    <script>
      $.widget.bridge("uibutton", $.ui.button);
    </script>');
array_push($jsStack, '<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>');
array_push($jsStack, '<script src="plugins/chart.js/Chart.min.js"></script>');
array_push($jsStack, '<script src="plugins/sparklines/sparkline.js"></script>');
array_push($jsStack, '<script src="plugins/jqvmap/jquery.vmap.min.js"></script> ');
array_push($jsStack, '<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>');
array_push($jsStack, '<script src="plugins/jquery-knob/jquery.knob.min.js"></script>');
array_push($jsStack, '<script src="plugins/moment/moment.min.js"></script>');
array_push($jsStack, '<script src="plugins/daterangepicker/daterangepicker.js"></script>');

array_push($jsStack, '<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>');
array_push($jsStack, '<script src="plugins/summernote/summernote-bs4.min.js"></script>');
array_push($jsStack, '<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>');
?>
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- /.content-header -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">Dashboard</h1>
      </div><!-- /.col -->
      <div class="col-sm-6">
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item"><a href="#">Home</a></li>
          <li class="breadcrumb-item active">Dashboard v1</li>
        </ol>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- Main content -->
<section class="content">
  <div class="container-fluid">
    <!-- Small boxes (Stat box) -->
    <div class="row">
      <div class="col-lg-3 col-6">
        <!-- small box -->
        <div class="small-box bg-info">
          <div class="inner">
            <h3 class="totalOrders">
            </h3>
            <p>Total Orders</p>
          </div>
          <div class="icon">
            <i class="ion ion-bag"></i>
          </div>
          <a href="index.php?page=pages/Order/list.php" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
        </div>
      </div>
      <!-- ./col -->
      <div class="col-lg-3 col-6">
        <!-- small box -->
        <div class="small-box bg-success">
          <div class="inner">
            <h3 class="totalProducts">53<sup style="font-size: 20px">%</sup></h3>

            <p>Total Product</p>
          </div>
          <div class="icon">
            <i class="fas fa-box-open"></i>
          </div>
          <a href="index.php?page=pages/Product/list.php" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
        </div>
      </div>
      <!-- ./col -->
      <div class="col-lg-3 col-6">
        <!-- small box -->
        <div class="small-box bg-warning">
          <div class="inner">
            <h3 class="totalUsers">44</h3>

            <p>User Registrations</p>
          </div>
          <div class="icon">
            <i class="ion ion-person-add"></i>
          </div>
          <a href="index.php?page=pages/User/list.php&type=customer" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
        </div>
      </div>
      <!-- ./col -->
      <div class="col-lg-3 col-6">
        <!-- small box -->
        <div class="small-box bg-danger">
          <div class="inner">
            <h3 class="totalRevenue">150.000.000 VNĐ</h3> <!-- Giả sử tổng doanh thu là 65,000 USD -->
            <p>Total Revenue</p>
          </div>
          <div class="icon">
            <i class="ion ion-cash"></i> <!-- Đổi icon thành biểu tượng tiền tệ -->
          </div>
          <a href="index.php?page=pages/Order/list.php" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
        </div>
      </div>
      <!-- ./col -->
    </div>
    <!-- /.row -->
    <!-- Main row -->
    <div class="row">
      <!-- Left col -->
      <section class="col-lg-7 connectedSortable">
        <!-- Custom tabs (Charts with tabs)-->
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">
              <i class="fas fa-chart-pie mr-1"></i>
              Sales
            </h3>
            <div class="card-tools">
              <ul class="nav nav-pills ml-auto">
                <li class="nav-item">
                  <a class="nav-link active" href="#revenue-chart" data-toggle="tab">Area</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#sales-chart" data-toggle="tab">Donut</a>
                </li>
              </ul>
            </div>
          </div><!-- /.card-header -->
          <div class="card-body">
            <div class="tab-content p-0">
              <!-- Morris chart - Sales -->
              <div class="chart tab-pane active" id="revenue-chart"
                style="position: relative; height: 300px;">
                <canvas id="revenue-chart-canvas" height="300" style="height: 300px;"></canvas>
              </div>
              <div class="chart tab-pane" id="sales-chart" style="position: relative; height: 300px;">
                <canvas id="sales-chart-canvas" height="300" style="height: 300px;"></canvas>
              </div>
            </div>
          </div><!-- /.card-body -->
        </div>
        <!-- /.card -->

      </section>
      <!-- /.Left col -->
      <!-- right col (We are only adding the ID to make the widgets sortable)-->
      <section class="col-lg-5 connectedSortable">
        <!-- /.card -->
        <!-- solid sales graph -->
        <div class="card bg-gradient-info">
          <div class="card-header border-0">
            <h3 class="card-title">
              <i class="fas fa-th mr-1"></i>
              Sales Graph
            </h3>

            <div class="card-tools">
              <button type="button" class="btn bg-info btn-sm" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
              <button type="button" class="btn bg-info btn-sm" data-card-widget="remove">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>
          <div class="card-body">
            <canvas class="chart" id="line-chart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
          </div>
          <!-- /.card-body -->
          <div class="card-footer bg-transparent">
            <div class="row">
              <div class="col-4 text-center">
                <input type="text" class="knob" data-readonly="true" value="20" data-width="60" data-height="60"
                  data-fgColor="#39CCCC">

                <div class="text-white">Mail-Orders</div>
              </div>
              <!-- ./col -->
              <div class="col-4 text-center">
                <input type="text" class="knob" data-readonly="true" value="50" data-width="60" data-height="60"
                  data-fgColor="#39CCCC">

                <div class="text-white">Online</div>
              </div>
              <!-- ./col -->
              <div class="col-4 text-center">
                <input type="text" class="knob" data-readonly="true" value="30" data-width="60" data-height="60"
                  data-fgColor="#39CCCC">

                <div class="text-white">In-Store</div>
              </div>
              <!-- ./col -->
            </div>
            <!-- /.row -->
          </div>
          <!-- /.card-footer -->
        </div>
      </section>
      <!-- right col -->
    </div>
    <!-- /.row (main row) -->
  </div><!-- /.container-fluid -->
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="assets/js/Statistics/statisticsActions.js"></script>