<?php
require 'db.php';
header('Content-Type: application/json');

session_start();
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(["ok" => false, "error" => "Not logged in"]);
    exit;
}

$user_id = (int)$_SESSION['user_id'];

$body = file_get_contents('php://input');
$data = json_decode($body, true);

if (!$data || !isset($data['items']) || !is_array($data['items']) || count($data['items']) === 0) {
    echo json_encode(["ok" => false, "error" => "No items provided"]);
    exit;
}

// Read checkout fields
$name     = trim($data['name']     ?? '');
$email    = trim($data['email']    ?? '');
$phone    = trim($data['phone']    ?? '');
$address  = trim($data['address']  ?? '');
$city     = trim($data['city']     ?? '');
$postcode = trim($data['postcode'] ?? '');
$country  = trim($data['country']  ?? '');
$note     = trim($data['note']     ?? '');

if ($name === '' || $email === '' || $phone === '' || $address === '' || $city === '' || $postcode === '' || $country === '') {
    echo json_encode(["ok" => false, "error" => "Please fill in all required fields (name, email, phone, full address)."]);
    exit;
}

// Validate items
$itemList = [];
foreach ($data['items'] as $item) {
    $pid = isset($item['product_id']) ? (int)$item['product_id'] : 0;
    $qty = isset($item['quantity']) ? (int)$item['quantity'] : 0;

    if ($pid <= 0 || $qty <= 0) {
        echo json_encode(["ok" => false, "error" => "Invalid item data"]);
        exit;
    }

    $itemList[] = [
        "product_id" => $pid,
        "quantity" => $qty
    ];
}

if (count($itemList) === 0) {
    echo json_encode(["ok" => false, "error" => "No valid items"]);
    exit;
}

$conn->begin_transaction();

try {
    // Insert order with customer / shipping info
    $stmt = $conn->prepare("
        INSERT INTO orders (
            user_id,
            total_price,
            customer_name,
            customer_email,
            customer_phone,
            shipping_address,
            shipping_city,
            shipping_postcode,
            shipping_country,
            customer_note
        ) VALUES (?, 0, ?, ?, ?, ?, ?, ?, ?, ?)
    ");

    $stmt->bind_param(
        "issssssss",
        $user_id,
        $name,
        $email,
        $phone,
        $address,
        $city,
        $postcode,
        $country,
        $note
    );

    $stmt->execute();
    $order_id = $stmt->insert_id;
    $stmt->close();

    $total = 0.0;

    $stmtProd = $conn->prepare("SELECT price FROM products WHERE id = ?");
    $stmtItem = $conn->prepare("INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)");

    foreach ($itemList as $it) {
        $pid = $it['product_id'];
        $qty = $it['quantity'];

        $stmtProd->bind_param("i", $pid);
        $stmtProd->execute();
        $res = $stmtProd->get_result();
        $prod = $res->fetch_assoc();

        if (!$prod) {
            throw new Exception("Product not found: " . $pid);
        }

        $price = (float)$prod['price'];
        $lineTotal = $price * $qty;
        $total += $lineTotal;

        $stmtItem->bind_param("iiid", $order_id, $pid, $qty, $price);
        $stmtItem->execute();
    }

    $stmtProd->close();
    $stmtItem->close();

    // Update total
    $stmtUp = $conn->prepare("UPDATE orders SET total_price = ? WHERE id = ?");
    $stmtUp->bind_param("di", $total, $order_id);
    $stmtUp->execute();
    $stmtUp->close();

    $conn->commit();

    echo json_encode([
        "ok" => true,
        "order_id" => $order_id,
        "total_price" => $total
    ]);
} catch (Exception $e) {
    $conn->rollback();
    echo json_encode([
        "ok" => false,
        "error" => "Order failed: " . $e->getMessage()
    ]);
}
