<?php
session_start();
header('Content-Type: application/json');

require '_auth.php';
require 'db.php';

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['logged_in' => false]);
    exit;
}

$username = null;
$stmt = $conn->prepare("SELECT username FROM users WHERE id = ? LIMIT 1");
if ($stmt) {
    $stmt->bind_param('i', $_SESSION['user_id']);
    $stmt->execute();
    $stmt->bind_result($dbUsername);
    if ($stmt->fetch()) {
        $username = $dbUsername;
    }
    $stmt->close();
}

echo json_encode([
    'logged_in' => true,
    'user_id' => $_SESSION['user_id'],
    'username' => $username,
    'role' => $_SESSION['role'],
    'csrf_token' => getCsrfToken()
]);
