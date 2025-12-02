<?php
require 'admin_check.php';
require 'db.php';

$id = $_GET['id'];

$stmt = $conn->prepare("SELECT id, name, artist, genre, category, price, stock, description, image_url FROM products WHERE id=?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$product = $result->fetch_assoc();

echo json_encode([
    'ok' => true,
    'product' => $product
]);
