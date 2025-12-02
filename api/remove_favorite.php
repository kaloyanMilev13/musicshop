<?php
session_start();
require 'db.php';
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['ok' => false, 'error' => 'Not logged in']);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);
$product_id = $data['product_id'] ?? null;

$stmt = $conn->prepare("DELETE FROM favorites WHERE user_id = ? AND product_id = ?");
$stmt->bind_param("ii", $_SESSION['user_id'], $product_id);
$stmt->execute();

echo json_encode(['ok' => true, 'message' => 'Removed from favorites']);
