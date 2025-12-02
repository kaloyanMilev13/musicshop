<?php
// register.php – user registration for MusicShop
// Expects JSON: { "username": "...", "email": "...", "password": "..." }
// Returns JSON: { ok: true } or { ok: false, error: "..." }

header('Content-Type: application/json; charset=utf-8');

require __DIR__ . '/db.php';

// Read JSON body
$raw = file_get_contents('php://input');
$data = json_decode($raw, true);

if (!is_array($data)) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Invalid JSON']);
    exit;
}

$username = trim($data['username'] ?? '');
$email    = trim($data['email'] ?? '');
$password = $data['password'] ?? '';

// Basic validation
if ($username === '' || $email === '' || $password === '') {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'All fields are required']);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Invalid email address']);
    exit;
}

if (strlen($password) < 6) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Password must be at least 6 characters']);
    exit;
}

// Check if username or email already exists
$checkSql = "SELECT id, username, email FROM users WHERE username = ? OR email = ? LIMIT 1";
$stmt = $conn->prepare($checkSql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'DB error (prepare check)']);
    exit;
}

$stmt->bind_param('ss', $username, $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows > 0) {
    $existing = $result->fetch_assoc();
    $field = ($existing['email'] === $email) ? 'Email' : 'Username';
    http_response_code(409);
    echo json_encode(['ok' => false, 'error' => "$field is already taken"]);
    $stmt->close();
    exit;
}
$stmt->close();

// Insert new user
$hash = password_hash($password, PASSWORD_DEFAULT);

$insertSql = "INSERT INTO users (username, email, password_hash, is_admin)
              VALUES (?, ?, ?, 0)";
$stmt = $conn->prepare($insertSql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'DB error (prepare insert)']);
    exit;
}

$stmt->bind_param('sss', $username, $email, $hash);

if ($stmt->execute()) {
    echo json_encode(['ok' => true, 'message' => 'Registered successfully']);
} else {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'DB error (insert failed)']);
}

$stmt->close();
$conn->close();

