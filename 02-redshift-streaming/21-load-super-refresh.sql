-- Refresh materialized view from kinesis data stream into a stage table with SUPER data type to hold streaming data.

CREATE MATERIALIZED VIEW cust_payment_tx_stream_stage AUTO REFRESH YES AS
SELECT approximate_arrival_timestamp,
partition_key,
shard_id,
sequence_number,
JSON_PARSE(kinesis_data) as data_json
FROM custpaytxn."cust-payment-txn-stream"
WHERE is_utf8(kinesis_data) AND can_json_parse(kinesis_data);

select count(*) from cust_payment_tx_stream_stage;

-- Use partiQL to query kinesis data from stage table, use periodic batches or transforms to refresh data as needed. Drop MV if created in previous section.

DROP MATERIALIZED VIEW IF EXISTS cust_payment_tx_stream;

CREATE MATERIALIZED VIEW cust_payment_tx_stream AUTO REFRESH NO AS
select 
approximate_arrival_timestamp,
partition_key,
shard_id,
sequence_number,
data_json."TRANSACTION_ID"::bigint as TRANSACTION_ID, 
data_json."TX_DATETIME"::character(50) as TX_DATETIME,
data_json."CUSTOMER_ID"::int as CUSTOMER_ID,
data_json."TERMINAL_ID"::int as TERMINAL_ID,
data_json."TX_AMOUNT"::decimal(18,2) as TX_AMOUNT,
data_json."TX_TIME_SECONDS"::int as TX_TIME_SECONDS,
data_json."TX_TIME_DAYS"::int as TX_TIME_DAYS
from cust_payment_tx_stream_stage;

REFRESH MATERIALIZED VIEW cust_payment_tx_stream;

select count(*) from cust_payment_tx_stream;
