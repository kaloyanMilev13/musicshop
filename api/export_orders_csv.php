<?php
// /musicshop/api/export_orders_csv.php
session_start();

require '_auth.php';
require 'db.php';

requireAdmin();

// 1) Load orders + user info
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
    jsonError('Internal server error', 500);
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
header('Content-Disposition: attachment; filename="orders-' . $date . '.csv"');

$out = fopen('php://output', 'w');
fputcsv($out, [
    'Order ID',
    'User ID',
    'Username',
    'Account Email',
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
        $order['user_id'],
        $order['username'],
        $order['email'],
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
