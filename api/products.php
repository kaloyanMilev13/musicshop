<?php
require 'db.php';

header('Content-Type: application/json');

$sql = "SELECT * FROM products WHERE 1";
$params = [];
$types  = "";

// Filter by main category
if (!empty($_GET['category'])) {
    $sql .= " AND category = ?";
    $params[] = $_GET['category'];
    $types .= "s";
}

// Filter by subcategory -> stored as `genre`
if (!empty($_GET['subcategory'])) {
    $sql .= " AND genre = ?";
    $params[] = $_GET['subcategory'];
    $types .= "s";
}

// Filter by music genre (only if your table has `music_genre` column)
if (!empty($_GET['music_genre'])) {
    $sql .= " AND music_genre = ?";
    $params[] = $_GET['music_genre'];
    $types .= "s";
}

// Search in name / artist
if (!empty($_GET['search'])) {
    $sql .= " AND (name LIKE CONCAT('%', ?, '%') OR artist LIKE CONCAT('%', ?, '%'))";
    $params[] = $_GET['search'];
    $params[] = $_GET['search'];
    $types .= "ss";
}

// Sorting
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
    $products[] = $row;
}

echo json_encode([
    "ok" => true,
    "products" => $products
]);
