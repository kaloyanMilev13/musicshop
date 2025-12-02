<?php
// /musicshop/api/admin_edit_news.php

require 'admin_check.php';   // ensures admin
require 'db.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);

$id      = isset($data['id'])      ? (int)$data['id']      : 0;
$title   = isset($data['title'])   ? trim($data['title']) : '';
$content = isset($data['content']) ? trim($data['content']) : '';

if ($id <= 0 || $title === '' || $content === '') {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Invalid id / title / content']);
    exit;
}

try {
    $stmt = $conn->prepare(
        "UPDATE news
         SET title = ?, content = ?
         WHERE id = ?"
    );
    $stmt->bind_param('ssi', $title, $content, $id);

    if (!$stmt->execute()) {
        throw new Exception("Update failed: " . $stmt->error);
    }

    echo json_encode([
        'ok'      => true,
        'updated' => $stmt->affected_rows
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'ok'    => false,
        'error' => $e->getMessage()
    ]);
}

