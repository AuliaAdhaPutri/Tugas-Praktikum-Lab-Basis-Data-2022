<?php
class MyQuery
{
  function __construct($conn)
  {
    $this->conn = $conn;
  }

  function show_data()
  {
    echo "Daftar Orderan" . "\n";

    $sql = "SELECT c.customerNumber AS id, o.orderDate AS tanggal, c.customerName AS nama
    FROM customers c
    JOIN orders o
    ON c.customerNumber = o.customerNumber
    ORDER BY o.orderDate DESC
    LIMIT 5";

    // Jalankan Query dan Menampilkan
    $result = $this->conn->query($sql);
    $resultSet = array();
    if ($result->num_rows > 0) {
      $index = 1;
      while ($row = $result->fetch_array()) {
        $resultSet[$index - 1] = $row['id'];
        printf("%d. %s \t| %s\n", $index, $row['tanggal'], $row['nama']);
        $index++;
      }
    } else {
      echo "Hasil 0";
    }

    return $resultSet;
  }

  function update_name()
  {
    // tampilkan nama dan pilih nama
    $list_id = $this->show_data();
    $input = -1;
    while ($input < 0 || $input > 4) {
      try {
        echo "Pilih nama yang hendak kamu ubah\n";
        $input = (int)readline('> ') - 1;
      } catch (Exception $e) {
        $input = -1;
      }
    }
    echo 'Input Nama Baru';
    $new_name = readline('> ');

    $sql = "set autocommit = 0";
    $this->conn->query($sql);

    $sql = "start transaction";
    $this->conn->query($sql);

    $sql = "UPDATE customers 
    SET customername = '$new_name'
    WHERE customerNumber = $list_id[$input]";


    $this->conn->query($sql);
    $this->show_data();
    while (true) {
      echo 'Simpan Perubahan?' . "\n" . '1. YES' . "\n" . '2. NO' . "\n";
      $choice = readline('> ');
      switch ($choice) {
        case 1:
          $sql = "COMMIT";
          $this->conn->query($sql);
          return;
        case 2:
          $sql = "ROLLBACK";
          $this->conn->query($sql);
          return;
        default:
          echo "Input Salah\n";
          break;
      }
    }
  }
}