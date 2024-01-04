---- ExampleCorp would like to run a targeted promotional campaign for it's Top100 urgent priority customers with highest spend.
SELECT c.full_name,
       c.email_address,
       o.o_orderpriority,
       Sum(h.tx_amount) cust_past_spend,
       Sum(p.tx_amount) cust_curr_spend
FROM   aurora_zeroetl.demodb.orders o        ------ Zero-ETL Integration Source: Aurora MySQL
       INNER JOIN postgres.customer_info c               ------ Federate Query Source: Aurora Postgres
               ON o.o_custkey = c.customer_id
       INNER JOIN (SELECT customer_id,
                          Sum(tx_amount) tx_amount
                   FROM   ant307_external.cust_payment_tx_history
                   GROUP  BY 1) h                       ------ Federate Query Source: Amazon S3
               ON o.o_custkey = h.customer_id
       INNER JOIN cust_payment_tx_stream p              ------ Streaming Source: Kinesis data streams
               ON p.customer_id = c.customer_id
WHERE  o.o_orderpriority = '1-URGENT'
GROUP  BY 1,
          2,
          3
ORDER  BY 4 DESC,
          5 DESC
LIMIT  100; 
