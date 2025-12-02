<?php
// /musicshop/api/admin_add_news.php

require 'admin_check.php'; // will exit with 403 JSON if not admin
require 'db.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);

$title   = isset($data['title'])   ? trim($data['title'])   : '';
$content = isset($data['content']) ? trim($data['content']) : '';

if ($title === '' || $content === '') {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Title and content are required']);
    exit;
}

$stmt = $conn->prepare(
    "INSERT INTO news (title, content)
     VALUES (?, ?)"
);
$stmt->bind_param('ss', $title, $content);

if (!$stmt->execute()) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Insert failed: ' . $stmt->error]);
    exit;
}

echo json_encode([
    'ok' => true,
    'id' => $stmt->insert_id
]);

