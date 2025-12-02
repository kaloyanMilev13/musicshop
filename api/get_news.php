<?php
// /musicshop/api/get_news.php
session_start();
header('Content-Type: application/json');
require 'db.php';

try {
    // Adjust column names if your table is slightly different
    $sql = "
        SELECT 
            id,
            title,
            content,
            created_at
        FROM news
        ORDER BY created_at DESC
    ";

    $stmt = $conn->prepare($sql);
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

