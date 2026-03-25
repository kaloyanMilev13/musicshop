<?php

function normalizeProductImagePath($imagePath) {
    if (!is_string($imagePath)) {
        return $imagePath;
    }

    $trimmed = trim($imagePath);
    if ($trimmed === '') {
        return $trimmed;
    }

    if (preg_match('#^https?://#i', $trimmed) === 1) {
        return $trimmed;
    }

    $parts = parse_url($trimmed);
    $path = $parts['path'] ?? $trimmed;
    $extension = strtolower(pathinfo($path, PATHINFO_EXTENSION));
    if ($extension !== 'jpg' && $extension !== 'jpeg') {
        return $trimmed;
    }

    $basename = pathinfo($path, PATHINFO_FILENAME);
    if ($basename === '') {
        return $trimmed;
    }

    $candidateDiskPath = __DIR__ . '/../images/products/' . $basename . '.png';
    if (!file_exists($candidateDiskPath)) {
        return $trimmed;
    }

    return 'images/products/' . $basename . '.png';
}

function resolveProductImageUrl($imagePath) {
    $fallback = 'images/products/placeholder.jpg';
    $normalizedPath = normalizeProductImagePath($imagePath);

    if (empty($normalizedPath)) {
        return $fallback;
    }

    $isRemote = preg_match('#^https?://#i', $normalizedPath) === 1;
    if ($isRemote) {
        return $normalizedPath;
    }

    $base = basename($normalizedPath);
    $localProductPath = __DIR__ . '/../images/products/' . $base;
    $localLegacyPath  = __DIR__ . '/../' . ltrim($normalizedPath, '/');

    if (file_exists($localProductPath)) {
        return 'images/products/' . $base . '?v=' . filemtime($localProductPath);
    }

    if (file_exists($localLegacyPath)) {
        return ltrim($normalizedPath, '/') . '?v=' . filemtime($localLegacyPath);
    }

    return $fallback;
}
