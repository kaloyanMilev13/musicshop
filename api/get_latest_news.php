<?php
// /musicshop/api/get_latest_news.php
session_start();
header('Content-Type: application/json');
require 'db.php';

$limit = 3;

try {
    $stmt = $conn->prepare(
        "SELECT id, title, content, created_at 
         FROM news 
         ORDER BY created_at DESC 
         LIMIT ?"
    );
    $stmt->bind_param('i', $limit);
    $stmt->execute();
    $res = $stmt->get_result();

    $news = [];
    while ($row = $res->fetch_assoc()) {
        $news[] = [
            'id'         => (int)$row['id'],
            'title'      => $row['title'],
            'content'    => $row['content'],
            'created_at' => $row['created_at'],
        ];
    }

    echo json_encode([
        'ok'   => true,
        'news' => $news
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'ok'    => false,
        'error' => $e->getMessage()
    ]);
}

