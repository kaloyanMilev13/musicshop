<?php
// /musicshop/api/admin_delete_news.php

require 'admin_check.php';
require 'db.php';
header('Content-Type: application/json');

// Support both JSON and form POST
$raw = file_get_contents('php://input');
$data = json_decode($raw, true);

$id = 0;

if (is_array($data) && isset($data['id'])) {
    $id = (int)$data['id'];
} elseif (isset($_POST['id'])) {
    $id = (int)$_POST['id'];
}

if ($id <= 0) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Invalid id']);
    exit;
}

$stmt = $conn->prepare("DELETE FROM news WHERE id = ?");
$stmt->bind_param('i', $id);

if (!$stmt->execute()) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Delete failed: ' . $stmt->error]);
    exit;
}

echo json_encode([
    'ok'      => true,
    'deleted' => $stmt->affected_rows
]);

