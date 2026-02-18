<?php
// /musicshop/api/admin_delete_all_orders.php
session_start();
header('Content-Type: application/json');

require '_auth.php';
require 'db.php';

requireAdmin();
requirePost();
requireCsrf();

$conn->begin_transaction();
try {
    if (!$conn->query("DELETE FROM order_items")) {
        throw new Exception('Delete order items failed');
    }
    if (!$conn->query("DELETE FROM orders")) {
        throw new Exception('Delete orders failed');
    }

    $conn->commit();
    echo json_encode(['ok' => true]);
} catch (Exception $e) {
    $conn->rollback();
    jsonError('Internal server error', 500);
}
