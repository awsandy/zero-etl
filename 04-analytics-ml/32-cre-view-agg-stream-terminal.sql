CREATE VIEW public.terminal_transformations
AS SELECT 
    TERMINAL_ID,
    TERMINAL_ID_NB_TX_1DAY_WINDOW, 
    TERMINAL_ID_RISK_1DAY_WINDOW, 
    TERMINAL_ID_NB_TX_7DAY_WINDOW, 
    TERMINAL_ID_RISK_7DAY_WINDOW,
    TERMINAL_ID_NB_TX_30DAY_WINDOW, 
    TERMINAL_ID_RISK_30DAY_WINDOW
FROM (
    SELECT 
    TERMINAL_ID, 
    MAX(cast(a.TX_DATETIME AS date) ) maxdt, 
    MIN(cast(a.TX_DATETIME AS date) ) mindt, 
    MAX(tx_fraud) mxtf, 
    MIN(tx_fraud) mntf, 
    SUM(CASE WHEN tx_fraud =1 THEN 1 ELSE 0 end) sumtxfraud,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -7 AND cast(getdate() AS date)  AND tx_fraud = 1 THEN tx_fraud ELSE 0 end) AS NB_FRAUD_DELAY1,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -7 AND cast(getdate() AS date) THEN tx_fraud ELSE 0 end)  AS NB_TX_DELAY1 ,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -8 AND cast(getdate() AS date)  AND tx_fraud = 1 THEN tx_fraud ELSE 0 end) AS NB_FRAUD_DELAY_WINDOW1,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -8 AND cast(getdate() AS date) THEN 1 ELSE 0 end)  AS NB_TX_DELAY_WINDOW1,
    NB_FRAUD_DELAY_WINDOW1-NB_FRAUD_DELAY1 AS NB_FRAUD_WINDOW1,
    NB_TX_DELAY_WINDOW1-NB_TX_DELAY1 AS TERMINAL_ID_NB_TX_1DAY_WINDOW,
    CASE WHEN TERMINAL_ID_NB_TX_1DAY_WINDOW = 0 
        THEN 0 
        ELSE NB_FRAUD_WINDOW1 / TERMINAL_ID_NB_TX_1DAY_WINDOW  
    end AS terminal_id_risk_1day_window ,--7 day
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -7 AND cast(getdate() AS date) AND tx_fraud = 1 THEN tx_fraud ELSE 0 end ) AS NB_FRAUD_DELAY7,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -7 AND cast(getdate() AS date) THEN 1 ELSE 0 end)  AS NB_TX_DELAY7,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -14 AND cast(getdate() AS date)  AND tx_fraud = 1 THEN tx_fraud ELSE 0 end) AS NB_FRAUD_DELAY_WINDOW7,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date) -14 AND cast(getdate() AS date) THEN 1 ELSE 0 end)  AS NB_TX_DELAY_WINDOW7,
    NB_FRAUD_DELAY_WINDOW7-NB_FRAUD_DELAY7 AS NB_FRAUD_WINDOW7,
    NB_TX_DELAY_WINDOW7-NB_TX_DELAY7 AS TERMINAL_ID_NB_TX_7DAY_WINDOW,
    CASE WHEN TERMINAL_ID_NB_TX_7DAY_WINDOW = 0 
        THEN 0 
        ELSE NB_FRAUD_WINDOW7 / TERMINAL_ID_NB_TX_7DAY_WINDOW 
    END AS terminal_id_risk_7day_window, --30 day period
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date)-7 AND cast(getdate() AS date)  AND tx_fraud = 1 THEN tx_fraud ELSE 0 end) AS NB_FRAUD_DELAY30,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date)-7 AND cast(getdate() AS date) THEN 1 ELSE 0 end)  AS NB_TX_DELAY30,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date)-37 AND cast(getdate() AS date)  AND tx_fraud = 1 THEN tx_fraud ELSE 0 end) AS NB_FRAUD_DELAY_WINDOW30,
    SUM(CASE WHEN cast(a.TX_DATETIME AS date) BETWEEN  cast(getdate() AS date)-37 AND cast(getdate() AS date) THEN 1 ELSE 0 end)  AS NB_TX_DELAY_WINDOW30,
    NB_FRAUD_DELAY_WINDOW30-NB_FRAUD_DELAY30 AS NB_FRAUD_WINDOW30,
    NB_TX_DELAY_WINDOW30-NB_TX_DELAY30 AS TERMINAL_ID_NB_TX_30DAY_WINDOW,
    CASE WHEN TERMINAL_ID_NB_TX_30DAY_WINDOW = 0 
        THEN 0 
        ELSE NB_FRAUD_WINDOW30 / TERMINAL_ID_NB_TX_30DAY_WINDOW 
    END AS TERMINAL_ID_RISK_30DAY_WINDOW
    FROM(
        SELECT 
            TERMINAL_ID, 
            TX_AMOUNT, 
            cast(TX_DATETIME AS timestamp) TX_DATETIME, 
            0 AS TX_FRAUD
        FROM cust_payment_tx_stream
        WHERE cast(TX_DATETIME AS date) BETWEEN cast(getdate() AS date) -37 AND cast(getdate() AS date)
        UNION ALL
        SELECT  
            TERMINAL_ID,
            TX_AMOUNT,
            TX_DATETIME,
            TX_FRAUD
        FROM cust_payment_tx_history  
        WHERE cast(TX_DATETIME AS date) BETWEEN cast(getdate() AS date) -37 AND cast(getdate() AS date)
    ) a
GROUP BY 1
);
