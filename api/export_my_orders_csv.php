<?php
// /musicshop/api/export_my_orders_csv.php
session_start();

require '_auth.php';
require 'db.php';

requireLogin();

$userId = (int)($_SESSION['user_id'] ?? 0);
if ($userId <= 0) {
    jsonError('Not logged in', 401);
}

// 1) Load orders for this user
$stmt = $conn->prepare("
    SELECT
        id,
        user_id,
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
");
$stmt->bind_param('i', $userId);
if (!$stmt->execute()) {
    jsonError('Internal server error', 500);
}
$res = $stmt->get_result();

$orders = [];
while ($row = $res->fetch_assoc()) {
    $id = (int)$row['id'];
    $orders[$id] = [
        "id" => $id,
        "user_id" => (int)$row['user_id'],
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

// 2) Load order items if there are any orders
if (!empty($orders)) {
    $ids = array_map('intval', array_keys($orders));
    $idsList = implode(',', $ids);

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
            if (!isset($orders[$oid])) {
                continue;
            }

            $orders[$oid]["items"][] = [
                "product_id" => (int)$r['product_id'],
                "name" => $r['name'],
                "quantity" => (int)$r['quantity'],
                "unit_price" => (float)$r['unit_price']
            ];
        }
    }
}

// 3) Output CSV
$date = date('Y-m-d');
header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="my-orders-' . $date . '.csv"');

$out = fopen('php://output', 'w');
fputcsv($out, [
    'Order ID',
    'Total Price',
    'Created At',
    'Customer Name',
    'Customer Email',
    'Customer Phone',
    'Shipping Address',
    'Shipping City',
    'Shipping Postcode',
    'Shipping Country',
    'Customer Note',
    'Items'
]);

foreach ($orders as $order) {
    $items = [];
    foreach ($order['items'] as $item) {
        $items[] = $item['name'] . ' x' . $item['quantity'] . ' @ ' . number_format($item['unit_price'], 2);
    }

    fputcsv($out, [
        $order['id'],
        number_format($order['total_price'], 2),
        $order['created_at'],
        $order['customer_name'],
        $order['customer_email'],
        $order['customer_phone'],
        $order['shipping_address'],
        $order['shipping_city'],
        $order['shipping_postcode'],
        $order['shipping_country'],
        $order['customer_note'],
        implode('; ', $items)
    ]);
}

fclose($out);
