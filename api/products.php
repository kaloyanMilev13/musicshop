<?php
require 'db.php';
header('Content-Type: application/json');

$sql = "SELECT id, name, artist, category, genre, price, stock, description, 
               image_url, music_genre 
        FROM products WHERE 1";
$params = [];
$types = "";

// Filters (unchanged)
if (!empty($_GET['category'])) {
    $sql .= " AND category = ?";
    $params[] = $_GET['category'];
    $types .= "s";
}
if (!empty($_GET['subcategory'])) {
    $sql .= " AND genre = ?";
    $params[] = $_GET['subcategory'];
    $types .= "s";
}
if (!empty($_GET['music_genre'])) {
    $sql .= " AND music_genre = ?";
    $params[] = $_GET['music_genre'];
    $types .= "s";
}
if (!empty($_GET['search'])) {
    $sql .= " AND (name LIKE CONCAT('%', ?, '%') OR artist LIKE CONCAT('%', ?, '%'))";
    $params[] = $_GET['search'];
    $params[] = $_GET['search'];
    $types .= "ss";
}
if (!empty($_GET['sort'])) {
    switch ($_GET['sort']) {
        case 'price_asc':  $sql .= " ORDER BY price ASC"; break;
        case 'price_desc': $sql .= " ORDER BY price DESC"; break;
        case 'name_asc':   $sql .= " ORDER BY name ASC"; break;
        case 'name_desc':  $sql .= " ORDER BY name DESC"; break;
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
                // keep whatever relative path works
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
