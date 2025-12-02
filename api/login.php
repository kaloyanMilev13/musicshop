<?php
session_start();
header('Content-Type: application/json');
require 'db.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['email'], $data['password'])) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Missing fields']);
    exit;
}

$email = $conn->real_escape_string($data['email']);
$password = $data['password'];

$res = $conn->query("SELECT id, password_hash, role FROM users WHERE email='$email' LIMIT 1");

if ($res && $res->num_rows === 1) {
    $user = $res->fetch_assoc();
    if (password_verify($password, $user['password_hash'])) {

        $_SESSION['user_id'] = $user['id'];
        $_SESSION['role'] = $user['role'];

        echo json_encode(['ok' => true, 'message' => 'Logged in']);
        exit;
    }
}

http_response_code(401);
echo json_encode(['ok' => false, 'error' => 'Invalid credentials']);
