<?php
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}

function jsonError(string $message, int $status = 400): void {
    http_response_code($status);
    echo json_encode(['ok' => false, 'error' => $message]);
    exit;
}

function requireLogin(): void {
    if (empty($_SESSION['user_id'])) {
        jsonError('Not logged in', 401);
    }
}

function requireAdmin(): void {
    requireLogin();
    if (($_SESSION['role'] ?? null) !== 'admin') {
        jsonError('Admin only', 403);
    }
}

function requirePost(): void {
    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
        jsonError('Method not allowed', 405);
    }
}

function getCsrfToken(): string {
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function requireCsrf(): void {
    $sessionToken = $_SESSION['csrf_token'] ?? '';
    $token = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '';

    if ($sessionToken === '' || $token === '' || !hash_equals($sessionToken, $token)) {
        jsonError('Invalid CSRF token', 403);
    }
}
