USE ecommerce_dw;

DROP VIEW IF EXISTS v_sales_detail;
CREATE VIEW v_sales_detail AS
SELECT
    f.sales_key,
    f.source_order_id,
    f.order_number,
    d.full_date,
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    c.customer_name,
    c.city,
    c.country,
    p.product_name,
    p.category,
    dl.rider_name,
    dl.vehicle_type,
    dl.courier_name,
    f.quantity,
    f.unit_price,
    f.line_total
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
LEFT JOIN dim_customer c ON c.customer_key = f.customer_key
JOIN dim_product p ON p.product_key = f.product_key
LEFT JOIN dim_delivery dl ON dl.delivery_key = f.delivery_key;
