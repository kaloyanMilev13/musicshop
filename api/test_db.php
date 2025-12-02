<?php
header('Content-Type: application/json; charset=utf-8');
require __DIR__ . '/db.php';

echo json_encode([
    'ok' => true,
    'server_info' => $conn->server_info,
    'host_info'   => $conn->host_info,
]);

