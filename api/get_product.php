<?php
require 'admin_check.php';
require 'db.php';
require 'product_image.php';

$id = $_GET['id'];

$stmt = $conn->prepare("SELECT id, name, artist, genre, category, price, stock, description, image_url FROM products WHERE id=?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$product = $result->fetch_assoc();

if ($product) {
    $product['image_url'] = normalizeProductImagePath($product['image_url'] ?? '');
}

echo json_encode([
    'ok' => true,
    'product' => $product
]);
