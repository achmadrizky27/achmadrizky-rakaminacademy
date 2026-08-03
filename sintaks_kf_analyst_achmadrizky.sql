/*

NAME/PARTICIPANT  : ACHMAD RIZKY
EMAIL             : achmadrizky.contact@gmail.com

*/

CREATE TABLE `rakamin-academy-bigdataanalyst.kimia_farma.kf_analyst` AS
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  b.branch_name,
  b.kota,
  b.provinsi,
  b.rating_cabang,
  t.customer_name,
  t.product_id,
  p.product_name,
  p.actual_price,
  t.discount_percentage,

  -- Persentase Gross Laba (tiered berdasarkan actual_price)
  CASE
    WHEN p.actual_price <= 50000 THEN 0.10
    WHEN p.actual_price > 50000 AND p.actual_price <= 100000 THEN 0.15
    WHEN p.actual_price > 100000 AND p.actual_price <= 300000 THEN 0.20
    WHEN p.actual_price > 300000 AND p.actual_price <= 500000 THEN 0.25
    WHEN p.actual_price > 500000 THEN 0.30
  END AS persentase_gross_laba,

  p.actual_price * (1 - t.discount_percentage) AS nett_sales,

  -- Nett Profit = Nett Sales * Persentase Gross Laba
  (p.actual_price * (1 - t.discount_percentage)) *
    CASE
      WHEN p.actual_price <= 50000 THEN 0.10
      WHEN p.actual_price > 50000 AND p.actual_price <= 100000 THEN 0.15
      WHEN p.actual_price > 100000 AND p.actual_price <= 300000 THEN 0.20
      WHEN p.actual_price > 300000 AND p.actual_price <= 500000 THEN 0.25
      WHEN p.actual_price > 500000 THEN 0.30
    END AS nett_profit,

  t.rating_transaksi

FROM `rakamin-academy-bigdataanalyst.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-academy-bigdataanalyst.kimia_farma.kf_product` p
  ON t.product_id = p.product_id
LEFT JOIN `rakamin-academy-bigdataanalyst.kimia_farma.kf_kantor_cabang` b
  ON t.branch_id = b.branch_id;