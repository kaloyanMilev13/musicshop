<?php
session_start();
require 'db.php';
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['ok' => false, 'error' => 'Not logged in']);
    exit;
}

$user_id = $_SESSION['user_id'];

$sql = "SELECT products.id, products.name, products.price, products.description
        FROM favorites
        JOIN products ON favorites.product_id = products.id
        WHERE favorites.user_id = $user_id";

$res = $conn->query($sql);

$favorites = [];
while ($row = $res->fetch_assoc()) {
    $favorites[] = $row;
}

echo json_encode(['ok' => true, 'favorites' => $favorites]);
