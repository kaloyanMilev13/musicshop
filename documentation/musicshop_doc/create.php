```php
$stmt = $conn->prepare("
    INSERT INTO products
    (name, artist, category, genre, price, stock, description, image_url)
    VALUES (?,?,?,?,?,?,?,?)
");

$stmt->bind_param(
    "ssssddss",
    $name,
    $artist,
    $category,
    $genre,
    $price,
    $stock,
    $description,
    $image_url
);

$stmt->execute();
```