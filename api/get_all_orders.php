<?php
// /musicshop/api/get_all_orders.php
require 'db.php';
header('Content-Type: application/json');

// Make sure there is no extra output before JSON
if (function_exists('ob_clean')) { @ob_clean(); }
@ini_set('display_errors', 0);

session_start();

// 1) Must be logged in (we will NOT check admin for now)
if (empty($_SESSION['user_id'])) {
    echo json_encode(["ok" => false, "error" => "Not logged in"]);
    exit;
}

// 2) Load orders + user info
$sql = "
    SELECT
        o.id,
        o.user_id,
        o.total_price,
        o.created_at,
        o.customer_name,
        o.customer_email,
        o.customer_phone,
        o.shipping_address,
        o.shipping_city,
        o.shipping_postcode,
        o.shipping_country,
        o.customer_note,
        u.username,
        u.email
    FROM orders o
    LEFT JOIN users u ON o.user_id = u.id
    ORDER BY o.created_at DESC
";

$res = $conn->query($sql);
if (!$res) {
    echo json_encode(["ok" => false, "error" => "Orders query error: " . $conn->error]);
    exit;
}

$orders = [];
while ($row = $res->fetch_assoc()) {
    $id = (int)$row['id'];
    $orders[$id] = [
        "id" => $id,
        "user_id" => (int)$row['user_id'],
        "username" => $row['username'] ?? null,
        "email" => $row['email'] ?? null,
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

// 3) Load order items if there are any orders
if (!empty($orders)) {
    $ids = array_map('intval', array_keys($orders));
    $idsList = implode(',', $ids); // safe because all are ints

    $sqlItems = "
        SELECT
            oi.order_id,
            oi.product_id,
            oi.quantity,
            oi.unit_price,
            p.name
        FROM order_items oi
        JOIN products p ON oi.product_id = p.id
        WHERE oi.order_id IN ($idsList)
        ORDER BY oi.order_id
    ";

    $resItems = $conn->query($sqlItems);
    if ($resItems) {
        while ($r = $resItems->fetch_assoc()) {
            $oid = (int)$r['order_id'];
            if (!isset($orders[$oid])) continue;

            $orders[$oid]["items"][] = [
                "product_id" => (int)$r['product_id'],
                "name" => $r['name'],
                "quantity" => (int)$r['quantity'],
                "unit_price" => (float)$r['unit_price']
            ];
        }
    }
}

// 4) Return JSON
echo json_encode([
    "ok" => true,
    "orders" => array_values($orders)
]);

