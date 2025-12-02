<?php
require 'db.php';
header('Content-Type: application/json');

session_start();
if (!isset($_SESSION['user_id'])) {
    echo json_encode(["ok" => false, "error" => "Not logged in"]);
    exit;
}

$user_id = $_SESSION['user_id'];

$sql = "
    SELECT
        id,
        total_price,
        created_at,
        customer_name,
        customer_email,
        customer_phone,
        shipping_address,
        shipping_city,
        shipping_postcode,
        shipping_country,
        customer_note
    FROM orders
    WHERE user_id = ?
    ORDER BY created_at DESC
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$res = $stmt->get_result();

$orders = [];
while ($row = $res->fetch_assoc()) {
    $orders[$row['id']] = [
        "id" => (int)$row['id'],
        "total_price" => (float)$row['total_price'],
        "created_at" => $row['created_at'],
        "customer_name" => $row['customer_name'],
        "customer_email" => $row['customer_email'],
        "customer_phone" => $row['customer_phone'],
        "shipping_address" => $row['shipping_address'],
        "shipping_city" => $row['shipping_city'],
        "shipping_postcode" => $row['shipping_postcode'],
        "shipping_country" => $row['shipping_country'],
        "customer_note" => $row['customer_note'],
        "items" => []
    ];
}
$stmt->close();

if (!empty($orders)) {
    $ids = implode(",", array_map('intval', array_keys($orders)));

    $sqlItems = "
        SELECT
            oi.order_id,
            oi.product_id,
            oi.quantity,
            oi.unit_price,
            p.name
        FROM order_items oi
        JOIN products p ON oi.product_id = p.id
        WHERE oi.order_id IN ($ids)
        ORDER BY oi.order_id
    ";
    $resItems = $conn->query($sqlItems);

    while ($row = $resItems->fetch_assoc()) {
        $orders[$row['order_id']]["items"][] = [
            "product_id" => (int)$row['product_id'],
            "name" => $row['name'],
            "quantity" => (int)$row['quantity'],
            "unit_price" => (float)$row['unit_price']
        ];
    }
}

echo json_encode([
    "ok" => true,
    "orders" => array_values($orders)
]);
