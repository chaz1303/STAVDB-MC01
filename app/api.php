<?php
declare(strict_types=1);

$config = require __DIR__ . '/config.php';
header('Content-Type: application/json');

try {
    $pdo = new PDO($config['dsn'], $config['user'], $config['password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
    $report = $_GET['report'] ?? 'monthly';
    $start = $_GET['start'] ?? '2025-01-01';
    $end = $_GET['end'] ?? '2025-12-31';
    $category = $_GET['category'] ?? '';
    $allowed = ['monthly', 'products', 'countries', 'delivery'];
    if (!in_array($report, $allowed, true)) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid report']);
        exit;
    }

    $queries = [
        'monthly' => "SELECT year, month, month_name, SUM(line_total) revenue, COUNT(DISTINCT source_order_id) orders
            FROM v_sales_detail WHERE full_date BETWEEN :start AND :end GROUP BY year, month, month_name ORDER BY year, month",
        'products' => "SELECT category, product_name, SUM(line_total) revenue, SUM(quantity) units
            FROM v_sales_detail WHERE full_date BETWEEN :start AND :end AND (:category = '' OR category = :category)
            GROUP BY category, product_name ORDER BY revenue DESC LIMIT 20",
        'countries' => "SELECT country, category, SUM(line_total) revenue, COUNT(DISTINCT source_order_id) orders
            FROM v_sales_detail WHERE full_date BETWEEN :start AND :end GROUP BY country, category ORDER BY revenue DESC LIMIT 30",
        'delivery' => "SELECT courier_name, vehicle_type, SUM(line_total) revenue, COUNT(DISTINCT source_order_id) orders
            FROM v_sales_detail WHERE full_date BETWEEN :start AND :end GROUP BY courier_name, vehicle_type ORDER BY revenue DESC",
    ];
    $statement = $pdo->prepare($queries[$report]);
    $statement->bindValue(':start', $start);
    $statement->bindValue(':end', $end);
    if ($report === 'products') {
        $statement->bindValue(':category', $category);
    }
    $statement->execute();
    echo json_encode(['report' => $report, 'rows' => $statement->fetchAll()], JSON_NUMERIC_CHECK);
} catch (Throwable $error) {
    http_response_code(500);
    echo json_encode(['error' => $error->getMessage()]);
}
