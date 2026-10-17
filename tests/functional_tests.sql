USE ecommerce_dw;

SET @expected_orders = (SELECT COUNT(DISTINCT source_order_id) FROM fact_sales);
SET @loaded_orders = (SELECT COUNT(DISTINCT source_order_id) FROM v_sales_detail);
SELECT 'ETL order preservation' AS test_name, @expected_orders = @loaded_orders AS passed, @expected_orders AS expected, @loaded_orders AS actual;

SELECT 'No orphan products' AS test_name, COUNT(*) = 0 AS passed
FROM fact_sales f LEFT JOIN dim_product p ON p.product_key = f.product_key
WHERE p.product_key IS NULL;

SELECT 'No negative measures' AS test_name, COUNT(*) = 0 AS passed
FROM fact_sales WHERE quantity < 0 OR unit_price < 0 OR line_total < 0;

SELECT 'Drill-down totals reconcile' AS test_name,
    ABS((SELECT SUM(line_total) FROM fact_sales) -
        (SELECT SUM(month_total) FROM (
            SELECT date_key, SUM(line_total) AS month_total FROM fact_sales GROUP BY date_key
        ) totals)) < 0.01 AS passed;

SELECT 'Slice returns only requested category' AS test_name, COUNT(*) = 0 AS passed
FROM v_sales_detail WHERE category = 'Electronics' AND category <> 'Electronics';
