CREATE TABLE bank_muamalat.bm_transaction AS
SELECT
    	bm_orders.Date AS order_date,
    	bm_productcategory.CategoryName AS category_name,
    	bm_products.ProdName AS product_name,
    	bm_products.Price AS product_price,
    	bm_orders.Quantity AS order_qty,
    	(bm_orders.Quantity * bm_products.Price) AS total_sales,
    	bm_customers.CustomerEmail AS cust_email,
    	bm_customers.CustomerCity AS cust_city
FROM
    	bank_muamalat.bm_productcategory
INNER JOIN
bank_muamalat.bm_products ON bm_productcategory.CategoryID = bm_products.Category
INNER JOIN
    (bank_muamalat.bm_customers INNER JOIN bank_muamalat.bm_orders ON bm_customers.CustomerID = bm_orders.CustomerID)
    	ON bm_products.ProdNumber = bm_orders.ProdNumber
ORDER BY
    	bm_orders.Date ASC;
