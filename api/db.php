<?php
// db.php - central DB connection for musicshop (MariaDB)

$DB_HOST = '127.0.0.1';   // or 'localhost'
$DB_PORT = 3306;          // default MariaDB/MySQL port
$DB_USER = 'kala';        // your phpMyAdmin user
$DB_PASS = 'kala';        // that user's password
$DB_NAME = 'musicshop';

$conn = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME, $DB_PORT);

if ($conn->connect_error) {
    http_response_code(500);
    die(json_encode(['error' => 'DB connect failed: ' . $conn->connect_error]));
}

$conn->set_charset('utf8mb4');
?>

