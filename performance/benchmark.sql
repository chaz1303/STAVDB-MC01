USE ecommerce_dw;

SET profiling = 1;

SELECT d.year, d.quarter, d.month, p.category, SUM(f.line_total) AS revenue
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
JOIN dim_product p ON p.product_key = f.product_key
WHERE d.full_date BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY d.year, d.quarter, d.month, p.category;

SHOW PROFILES;
ANALYZE
SELECT d.year, d.quarter, d.month, p.category, SUM(f.line_total) AS revenue
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
JOIN dim_product p ON p.product_key = f.product_key
WHERE d.full_date BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY d.year, d.quarter, d.month, p.category;
