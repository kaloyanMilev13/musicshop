<?php
// /musicshop/api/admin_delete_order.php
session_start();
header('Content-Type: application/json');

require '_auth.php';
require 'db.php';

requireAdmin();
requirePost();
requireCsrf();

$raw = file_get_contents('php://input');
$payload = json_decode($raw, true);
$id = 0;
if (is_array($payload) && isset($payload['id'])) {
    $id = (int)$payload['id'];
} elseif (isset($_POST['id'])) {
    $id = (int)$_POST['id'];
}

if ($id <= 0) {
    jsonError('Invalid order id', 400);
}

$conn->begin_transaction();
try {
    $stmtItems = $conn->prepare("DELETE FROM order_items WHERE order_id = ?");
    $stmtItems->bind_param('i', $id);
    if (!$stmtItems->execute()) {
        throw new Exception('Delete order items failed');
    }
    $stmtItems->close();

    $stmtOrder = $conn->prepare("DELETE FROM orders WHERE id = ?");
    $stmtOrder->bind_param('i', $id);
    if (!$stmtOrder->execute()) {
        throw new Exception('Delete order failed');
    }
    $affected = $stmtOrder->affected_rows;
    $stmtOrder->close();

    $conn->commit();
    echo json_encode([
        'ok' => true,
        'deleted' => $affected > 0
    ]);
} catch (Exception $e) {
    $conn->rollback();
    jsonError('Internal server error', 500);
}
