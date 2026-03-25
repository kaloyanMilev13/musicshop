<?php
session_start();
require 'db.php';
require 'product_image.php';
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['ok' => false, 'error' => 'Not logged in']);
    exit;
}

$user_id = $_SESSION['user_id'];

$sql = "SELECT p.id,
               p.name,
               p.price,
               p.description,
               p.category,
               p.genre,
               p.music_genre,
               p.image_url,
               p.artist
        FROM favorites f
        JOIN products p ON f.product_id = p.id
        WHERE f.user_id = ?";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Internal server error']);
    exit;
}

$stmt->bind_param('i', $user_id);

if (!$stmt->execute()) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Internal server error']);
    $stmt->close();
    exit;
}

$res = $stmt->get_result();
$favorites = [];
while ($row = $res->fetch_assoc()) {
    $row['image_url'] = resolveProductImageUrl($row['image_url'] ?? '');
    $favorites[] = $row;
}
$stmt->close();

echo json_encode(['ok' => true, 'favorites' => $favorites]);
