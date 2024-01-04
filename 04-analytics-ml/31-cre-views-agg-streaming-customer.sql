CREATE VIEW public.customer_transformations
AS SELECT 
    customer_id, 
    CUSTOMER_ID_NB_TX_1DAY_WINDOW, 
    CUSTOMER_ID_AVG_AMOUNT_1DAY_WINDOW,
    CUSTOMER_ID_NB_TX_7DAY_WINDOW,
    CUSTOMER_ID_AVG_AMOUNT_7DAY_WINDOW,
    CUSTOMER_ID_NB_TX_30DAY_WINDOW, 
    CUSTOMER_ID_AVG_AMOUNT_30DAY_WINDOW
FROM (
    SELECT 
        customer_id,
        SUM(CASE WHEN cast(a.TX_DATETIME AS date) = cast(getdate() AS date) THEN TX_AMOUNT  ELSE 0 end) AS CUSTOMER_ID_NB_TX_1DAY_WINDOW,
        AVG(CASE WHEN cast(a.TX_DATETIME AS date) = cast(getdate() AS date) THEN TX_AMOUNT ELSE 0 end ) AS CUSTOMER_ID_AVG_AMOUNT_1DAY_WINDOW,
        SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -7 AND cast(getdate() AS date) THEN TX_AMOUNT ELSE 0 end) AS CUSTOMER_ID_NB_TX_7DAY_WINDOW,
        AVG(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -7 AND cast(getdate() AS date) THEN TX_AMOUNT  ELSE 0 end ) AS CUSTOMER_ID_AVG_AMOUNT_7DAY_WINDOW,
        SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -30 AND cast(getdate() AS date) THEN TX_AMOUNT ELSE 0 end) AS CUSTOMER_ID_NB_TX_30DAY_WINDOW,
        AVG( CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -30 AND cast(getdate() AS date) THEN TX_AMOUNT  ELSE 0 end ) AS CUSTOMER_ID_AVG_AMOUNT_30DAY_WINDOW
    FROM (
        SELECT 
            CUSTOMER_ID, 
            TERMINAL_ID, 
            TX_AMOUNT, 
            cast(TX_DATETIME AS timestamp) TX_DATETIME
        FROM CUST_PAYMENT_TX_STREAM  --retrieve streaming data
        WHERE cast(TX_DATETIME AS date) BETWEEN cast(getdate() AS date) -37 AND cast(getdate() AS date)
        UNION
        SELECT 
            CUSTOMER_ID, 
            TERMINAL_ID, 
            TX_AMOUNT,
            cast(TX_DATETIME AS timestamp) TX_DATETIME
        FROM cust_payment_tx_history   -- retrieve historical data
        WHERE  cast(TX_DATETIME AS date) BETWEEN cast(getdate() AS date) -37 AND cast(getdate() AS date)
    ) a
GROUP BY 1
);
