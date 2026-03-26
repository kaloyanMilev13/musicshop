<?php

function musicGenreCasefold(string $value): string
{
    $value = trim($value);
    if (function_exists('mb_strtolower')) {
        return mb_strtolower($value, 'UTF-8');
    }
    return strtolower($value);
}

function musicGenreAliasMap(): array
{
    return [
        'Rock' => ['Rock', 'Рок'],
        'Metal' => ['Metal', 'Метъл'],
        'Pop' => ['Pop', 'Поп'],
        'Hip-Hop' => ['Hip-Hop', 'Hip Hop', 'Хип-Хоп', 'Хип-хоп', 'Хип Хоп', 'Хип хоп'],
        'Rap' => ['Rap', 'Рап'],
        'Jazz' => ['Jazz', 'Джаз'],
        'Blues' => ['Blues', 'Блус'],
        'Electronic' => ['Electronic', 'Електронна'],
        'House' => ['House', 'Хаус'],
        'Techno' => ['Techno', 'Техно'],
        'Drum & Bass' => ['Drum & Bass', 'Drum and Bass', 'Дръм енд бейс'],
        'Classical' => ['Classical', 'Класическа', 'Класически'],
        'Soundtrack' => ['Soundtrack', 'Саундтрак'],
        'Folk' => ['Folk', 'Фолклор'],
        'Other' => ['Other', 'Други']
    ];
}

function normalizeMusicGenreValue(?string $value): ?string
{
    if ($value === null) {
        return null;
    }

    $trimmed = trim($value);
    if ($trimmed === '') {
        return null;
    }

    $needle = musicGenreCasefold($trimmed);
    foreach (musicGenreAliasMap() as $canonical => $aliases) {
        foreach ($aliases as $alias) {
            if (musicGenreCasefold($alias) === $needle) {
                return $canonical;
            }
        }
    }

    return $trimmed;
}

function getMusicGenreAliases(?string $value): array
{
    $normalized = normalizeMusicGenreValue($value);
    if ($normalized === null) {
        return [];
    }

    $map = musicGenreAliasMap();
    $aliases = $map[$normalized] ?? [$normalized];
    $aliases[] = $normalized;

    return array_values(array_unique(array_filter(array_map('trim', $aliases))));
}
