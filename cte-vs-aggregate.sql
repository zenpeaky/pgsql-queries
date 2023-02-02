-- AGGREGATE

SELECT 
  date_trunc('month', ord_date) AS bulan, 
  SUM(CASE WHEN ord_result = 'ORDER' OR ord_result = 'ACC' OR ord_result = 'SSU' THEN 1 ELSE 0 END) AS "ORDER",
  SUM(CASE WHEN ord_result = 'ACC' OR ord_result = 'SSU' THEN 1 ELSE 0 END) AS ACC,
  SUM(CASE WHEN ord_result = 'SSU' THEN 1 ELSE 0 END) AS SSU,
  COUNT(*) AS total
FROM 
  orders
WHERE 
  ord_date >= '2023-01-01' 
  AND ord_date < '2024-01-01' 
GROUP BY 
  date_trunc('month', ord_date)
ORDER BY 
  bulan

-- CTE

WITH cte AS (
  SELECT 
    date_trunc('month', ord_date) AS bulan, 
    ord_result, 
    count(ord_result) AS jumlah
  FROM 
    orders 
  WHERE 
    ord_date >= '2023-01-01' 
    AND ord_date < '2024-01-01' 
  GROUP BY 
    bulan, ord_result
)
SELECT 
  bulan, 
  SUM(CASE WHEN ord_result = 'ORDER' or ord_result = 'ACC' or ord_result = 'SSU' THEN jumlah ELSE 0 END) AS ORDER,
  SUM(CASE WHEN ord_result = 'ACC' or ord_result = 'SSU' THEN jumlah ELSE 0 END) AS ACC,
  SUM(CASE WHEN ord_result = 'SSU' THEN jumlah ELSE 0 END) AS SSU,
  SUM(jumlah) AS total
FROM 
  cte
GROUP BY 
  bulan
ORDER BY 
  bulan
