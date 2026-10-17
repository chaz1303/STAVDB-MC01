<?php
declare(strict_types=1);

$options = getopt('', ['host::', 'port::', 'user::', 'password::', 'source::', 'warehouse::']);
$host = $options['host'] ?? '127.0.0.1';
$port = $options['port'] ?? '3306';
$user = $options['user'] ?? 'root';
$password = $options['password'] ?? '';
$source = $options['source'] ?? 'faker';
$warehouse = $options['warehouse'] ?? 'ecommerce_dw';

$pdo = new PDO("mysql:host=$host;port=$port;charset=utf8mb4", $user, $password, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$quote = static fn (string $name): string => '`' . str_replace('`', '``', $name) . '`';
$sourceName = $quote($source);
$warehouseName = $quote($warehouse);

$pdo->exec("CREATE DATABASE IF NOT EXISTS $warehouseName CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
$pdo->exec("USE $warehouseName");
$schema = file_get_contents(__DIR__ . '/../database/01_warehouse_schema.sql');
$views = file_get_contents(__DIR__ . '/../database/02_warehouse_views.sql');
$pdo->exec($schema);
$pdo->exec($views);

try {
    $pdo->exec('SET FOREIGN_KEY_CHECKS = 0');
    foreach (['fact_sales', 'dim_delivery', 'dim_product', 'dim_customer', 'dim_date'] as $table) {
        $pdo->exec("TRUNCATE TABLE $table");
    }
    $pdo->exec('SET FOREIGN_KEY_CHECKS = 1');
    $pdo->beginTransaction();

    $pdo->exec("INSERT INTO dim_customer (source_user_id, username, customer_name, city, country, gender, birth_date)
        SELECT id, COALESCE(NULLIF(TRIM(username), ''), CONCAT('user-', id)),
            TRIM(CONCAT(COALESCE(firstName, ''), ' ', COALESCE(lastName, ''))),
            COALESCE(NULLIF(TRIM(city), ''), 'Unknown'), COALESCE(NULLIF(TRIM(country), ''), 'Unknown'),
            COALESCE(NULLIF(UPPER(TRIM(gender)), ''), 'U'),
            CASE WHEN dateOfBirth REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(dateOfBirth, '%m/%d/%Y')
                 WHEN dateOfBirth REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(dateOfBirth, '%Y-%m-%d') END
        FROM $sourceName.Users");

    $pdo->exec("INSERT INTO dim_product (source_product_id, product_code, product_name, category)
        SELECT id, COALESCE(NULLIF(TRIM(productCode), ''), CONCAT('product-', id)),
            COALESCE(NULLIF(TRIM(name), ''), 'Unknown product'),
            COALESCE(NULLIF(UPPER(TRIM(category)), ''), 'UNCATEGORIZED')
        FROM $sourceName.Products");

    $pdo->exec("INSERT INTO dim_delivery (source_rider_id, rider_name, vehicle_type, courier_name, rider_gender)
        SELECT r.id, TRIM(CONCAT(COALESCE(r.firstName, ''), ' ', COALESCE(r.lastName, ''))),
            COALESCE(NULLIF(TRIM(r.vehicleType), ''), 'Unknown'), COALESCE(NULLIF(TRIM(c.name), ''), 'Unknown'),
            COALESCE(NULLIF(UPPER(TRIM(r.gender)), ''), 'U')
        FROM $sourceName.Riders r LEFT JOIN $sourceName.Couriers c ON c.id = r.courierId");

    $pdo->exec("INSERT INTO dim_date (date_key, full_date, year, quarter, month, month_name, week_of_year, day_of_month, day_name)
        SELECT DISTINCT DATE_FORMAT(parsed_date, '%Y%m%d') + 0, parsed_date, YEAR(parsed_date), QUARTER(parsed_date), MONTH(parsed_date),
            DATE_FORMAT(parsed_date, '%M'), WEEK(parsed_date, 3), DAY(parsed_date), DATE_FORMAT(parsed_date, '%W')
        FROM (
            SELECT CASE WHEN deliveryDate REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(deliveryDate, '%Y-%m-%d')
                        WHEN deliveryDate REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(deliveryDate, '%m/%d/%Y') END AS parsed_date
            FROM $sourceName.Orders
        ) dates WHERE parsed_date IS NOT NULL");

    $pdo->exec("INSERT INTO fact_sales (source_order_id, order_number, date_key, customer_key, product_key, delivery_key, quantity, unit_price, line_total)
        SELECT o.id, COALESCE(NULLIF(TRIM(o.orderNumber), ''), CONCAT('order-', o.id)),
            DATE_FORMAT(parsed.parsed_date, '%Y%m%d') + 0, c.customer_key, p.product_key, d.delivery_key,
            COALESCE(NULLIF(oi.quantity, 0), 1), CAST(COALESCE(p_source.price, 0) AS DECIMAL(12,2)),
            CAST(COALESCE(NULLIF(oi.quantity, 0), 1) * COALESCE(p_source.price, 0) AS DECIMAL(14,2))
        FROM $sourceName.OrderItems oi
        JOIN $sourceName.Orders o ON o.id = oi.OrderId
        JOIN $sourceName.Products p_source ON p_source.id = oi.ProductId
        JOIN dim_product p ON p.source_product_id = p_source.id
        LEFT JOIN dim_customer c ON c.source_user_id = o.userId
        LEFT JOIN dim_delivery d ON d.source_rider_id = o.deliveryRiderId
        JOIN (
            SELECT id, CASE WHEN deliveryDate REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(deliveryDate, '%Y-%m-%d')
                            WHEN deliveryDate REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(deliveryDate, '%m/%d/%Y') END AS parsed_date
            FROM $sourceName.Orders
        ) parsed ON parsed.id = o.id AND parsed.parsed_date IS NOT NULL");

    $pdo->commit();
    $counts = $pdo->query("SELECT (SELECT COUNT(*) FROM fact_sales) fact_rows, (SELECT COUNT(*) FROM dim_date) date_rows,
        (SELECT COUNT(*) FROM dim_customer) customer_rows, (SELECT COUNT(*) FROM dim_product) product_rows,
        (SELECT COUNT(*) FROM dim_delivery) delivery_rows")->fetch();
    echo json_encode($counts, JSON_PRETTY_PRINT) . PHP_EOL;
} catch (Throwable $error) {
    try {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
    } catch (Throwable $rollbackError) {
    }
    fwrite(STDERR, $error->getMessage() . PHP_EOL);
    exit(1);
}
