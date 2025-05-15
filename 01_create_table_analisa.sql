-- Create Analisa Table
CREATE OR REPLACE TABLE `rakamin-kf-analytics-459913.kimia_farma.analisa_kimia_farma` AS
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,
  c.rating AS rating_cabang,
  t.customer_name,
  t.product_id,
  p.product_name,
  t.price AS actual_price,
  t.discount_percentage,
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price <= 100000 THEN 0.15
    WHEN t.price <= 300000 THEN 0.20
    WHEN t.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,
  t.price * (1 - t.discount_percentage / 100.0) AS nett_sales,
  (t.price * (1 - t.discount_percentage / 100.0)) *
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price <= 100000 THEN 0.15
    WHEN t.price <= 300000 THEN 0.20
    WHEN t.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS nett_profit,
  t.rating AS rating_transaksi
FROM `rakamin-kf-analytics-459913.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-kf-analytics-459913.kimia_farma.kf_kantor_cabang` c
  ON t.branch_id = c.branch_id
LEFT JOIN `rakamin-kf-analytics-459913.kimia_farma.kf_product` p
  ON t.product_id = p.product_id;
