<?php
require 'admin_check.php';
require 'db.php';

if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    echo json_encode(['ok' => false, 'error' => 'Invalid ID']);
    exit;
}

$id = intval($_GET['id']);

$stmt = $conn->prepare("DELETE FROM products WHERE id=?");
$stmt->bind_param("i", $id);
$stmt->execute();

if ($stmt->affected_rows > 0) {
    echo json_encode(['ok' => true]);
} else {
    echo json_encode(['ok' => false, 'error' => 'Product not found']);
}
