EXPLAIN
SELECT d_year, d_month, COUNT(*)
FROM ant307_view_cust_payment_tx
WHERE d_year = 2023 AND d_month IN (1,2) and terminal_id = 9999
GROUP BY 1,2 
ORDER BY 1,2;
