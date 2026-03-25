<?php

function normalizeNewsImagePath($imagePath) {
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

    return ltrim($trimmed, '/');
}

function resolveNewsImageUrl($imagePath) {
    $fallback = 'images/news/placeholder.jpg';
    $normalizedPath = normalizeNewsImagePath($imagePath);

    if (empty($normalizedPath)) {
        return $fallback;
    }

    if (preg_match('#^https?://#i', $normalizedPath) === 1) {
        return $normalizedPath;
    }

    $localNewsPath = __DIR__ . '/../' . $normalizedPath;
    if (file_exists($localNewsPath)) {
        return $normalizedPath . '?v=' . filemtime($localNewsPath);
    }

    return $fallback;
}
