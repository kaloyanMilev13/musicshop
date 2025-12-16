<?php
session_start();
require 'db.php';
header('Content-Type: application/json');

$userId = $_SESSION['user_id'] ?? null;
$params = [];
$types = "";

$selectFavorite = $userId
    ? ", CASE WHEN f.product_id IS NULL THEN 0 ELSE 1 END AS is_favorite"
    : ", 0 AS is_favorite";

$sql = "SELECT 
            p.id, p.name, p.artist, p.category, p.genre, p.price, p.stock, p.description,
            p.image_url, p.music_genre
            $selectFavorite
        FROM products p";

if ($userId) {
    // Join against a distinct list to avoid duplicate products when favorites table has duplicates
    $sql .= " LEFT JOIN (SELECT DISTINCT product_id FROM favorites WHERE user_id = ?) f ON f.product_id = p.id";
    $params[] = $userId;
    $types .= "i";
}

$sql .= " WHERE 1";

// Filters
if (!empty($_GET['category'])) {
    $sql .= " AND p.category = ?";
    $params[] = $_GET['category'];
    $types .= "s";
}
if (!empty($_GET['id'])) {
    $sql .= " AND p.id = ?";
    $params[] = (int)$_GET['id'];
    $types .= "i";
}
if (!empty($_GET['subcategory'])) {
    $sql .= " AND p.genre = ?";
    $params[] = $_GET['subcategory'];
    $types .= "s";
}
if (!empty($_GET['music_genre'])) {
    $sql .= " AND p.music_genre = ?";
    $params[] = $_GET['music_genre'];
    $types .= "s";
}
if (!empty($_GET['search'])) {
    $sql .= " AND (p.name LIKE CONCAT('%', ?, '%') OR p.artist LIKE CONCAT('%', ?, '%'))";
    $params[] = $_GET['search'];
    $params[] = $_GET['search'];
    $types .= "ss";
}
if (!empty($_GET['sort'])) {
    switch ($_GET['sort']) {
        case 'price_asc':  $sql .= " ORDER BY p.price ASC"; break;
        case 'price_desc': $sql .= " ORDER BY p.price DESC"; break;
        case 'name_asc':   $sql .= " ORDER BY p.name ASC"; break;
        case 'name_desc':  $sql .= " ORDER BY p.name DESC"; break;
    }
}

$stmt = $conn->prepare($sql);
if ($params) {
    $stmt->bind_param($types, ...$params);
}
$stmt->execute();
$res = $stmt->get_result();

$products = [];
while ($row = $res->fetch_assoc()) {
    $imagePath = $row['image_url'] ?? '';

    // Normalize image paths: prefer local files in /images/products/
    if (!empty($imagePath)) {
        $isRemote = preg_match('#^https?://#i', $imagePath) === 1;
        if (!$isRemote) {
            $base = basename($imagePath);
            $localProductPath = __DIR__ . '/../images/products/' . $base;
            $localLegacyPath  = __DIR__ . '/../' . ltrim($imagePath, '/');

            if (file_exists($localProductPath)) {
                $row['image_url'] = 'images/products/' . $base;
            } elseif (file_exists($localLegacyPath)) {
                $row['image_url'] = ltrim($imagePath, '/');
            } else {
                $row['image_url'] = 'images/products/placeholder.jpg';
            }
        }
    }

    if (empty($row['image_url'])) {
        $row['image_url'] = 'images/products/placeholder.jpg';
    }

    $products[] = $row;
}

echo json_encode(["ok" => true, "products" => $products]);
