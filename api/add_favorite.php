<?php
session_start();
require 'db.php';
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['ok' => false, 'error' => 'Not logged in']);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['product_id'])) {
    echo json_encode(['ok' => false, 'error' => 'Missing product ID']);
    exit;
}

$product_id = (int)$data['product_id'];

$stmt = $conn->prepare("INSERT INTO favorites (user_id, product_id) VALUES (?, ?)");
$stmt->bind_param("ii", $_SESSION['user_id'], $product_id);

if ($stmt->execute()) {
    echo json_encode(['ok' => true]);
} else {
    echo json_encode(['ok' => false, 'error' => $conn->error]);
}
