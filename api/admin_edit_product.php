<?php
require 'admin_check.php';
require 'db.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['id'])) {
    echo json_encode(['ok' => false, 'error' => 'Missing product ID']);
    exit;
}

$id = (int)$data['id'];
$name = $data['name'];
$artist = $data['artist'] ?? null;
$category = $data['category'];
$genre = $data['genre'] ?? null;
$price = (float)$data['price'];
$stock = isset($data['stock']) ? (int)$data['stock'] : 0;
$description = $data['description'] ?? null;
$image_url = $data['image_url'] ?? null;

$format = $data['format'] ?? null;
$music_genre = $data['music_genre'] ?? null;
$size = $data['size'] ?? null;
$color = $data['color'] ?? null;
$merch_type = $data['merch_type'] ?? null;
$instrument_subtype = $data['instrument_subtype'] ?? null;
$accessory_type = $data['accessory_type'] ?? null;

$stmt = $conn->prepare("
    UPDATE products
    SET name=?, artist=?, category=?, genre=?, price=?, stock=?, description=?, image_url=?,
        format=?, music_genre=?, size=?, color=?, merch_type=?, instrument_subtype=?, accessory_type=?
    WHERE id=?
");

$stmt->bind_param(
    "ssssddsssssssssi",
    $name,
    $artist,
    $category,
    $genre,
    $price,
    $stock,
    $description,
    $image_url,
    $format,
    $music_genre,
    $size,
    $color,
    $merch_type,
    $instrument_subtype,
    $accessory_type,
    $id
);

if ($stmt->execute()) {
    echo json_encode(['ok' => true]);
} else {
    echo json_encode(['ok' => false, 'error' => $stmt->error]);
}
