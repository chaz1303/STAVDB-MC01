USE ecommerce_dw;

SELECT year, month, month_name, category, SUM(line_total) AS revenue, SUM(quantity) AS units
FROM v_sales_detail
WHERE full_date BETWEEN :start_date AND :end_date
GROUP BY year, month, month_name, category
WITH ROLLUP;

SELECT year, quarter, month, month_name, SUM(line_total) AS revenue, COUNT(DISTINCT source_order_id) AS orders
FROM v_sales_detail
WHERE full_date BETWEEN :start_date AND :end_date
GROUP BY year, quarter, month, month_name
ORDER BY year, quarter, month;

SELECT category, product_name, SUM(line_total) AS revenue, SUM(quantity) AS units
FROM v_sales_detail
WHERE category = :category AND full_date BETWEEN :start_date AND :end_date
GROUP BY category, product_name
ORDER BY revenue DESC;

SELECT category, country, SUM(line_total) AS revenue, COUNT(DISTINCT source_order_id) AS orders
FROM v_sales_detail
WHERE category IN (:category_a, :category_b)
  AND country IN (:country_a, :country_b)
  AND full_date BETWEEN :start_date AND :end_date
GROUP BY category, country
ORDER BY category, country;

SELECT year, month,
    SUM(CASE WHEN category = :category_a THEN line_total ELSE 0 END) AS category_a_revenue,
    SUM(CASE WHEN category = :category_b THEN line_total ELSE 0 END) AS category_b_revenue,
    SUM(CASE WHEN category = :category_c THEN line_total ELSE 0 END) AS category_c_revenue
FROM v_sales_detail
WHERE full_date BETWEEN :start_date AND :end_date
GROUP BY year, month
ORDER BY year, month;

EXPLAIN SELECT d.year, d.quarter, d.month, p.category, SUM(f.line_total)
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
JOIN dim_product p ON p.product_key = f.product_key
WHERE d.full_date BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY d.year, d.quarter, d.month, p.category;
