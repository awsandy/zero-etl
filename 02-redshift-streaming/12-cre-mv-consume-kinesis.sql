CREATE MATERIALIZED VIEW cust_payment_tx_stream
AUTO REFRESH YES
AS
SELECT approximate_arrival_timestamp ,
partition_key,
shard_id,
sequence_number,
json_extract_path_text(from_varbyte(kinesis_data, 'utf-8'),'TRANSACTION_ID')::bigint as TRANSACTION_ID,
json_extract_path_text(from_varbyte(kinesis_data, 'utf-8'),'TX_DATETIME')::character(50) as TX_DATETIME,
json_extract_path_text(from_varbyte(kinesis_data, 'utf-8'),'CUSTOMER_ID')::int as CUSTOMER_ID,
json_extract_path_text(from_varbyte(kinesis_data, 'utf-8'),'TERMINAL_ID')::int as TERMINAL_ID,
json_extract_path_text(from_varbyte(kinesis_data, 'utf-8'),'TX_AMOUNT')::decimal(18,2) as TX_AMOUNT,
json_extract_path_text(from_varbyte(kinesis_data, 'utf-8'),'TX_TIME_SECONDS')::int as TX_TIME_SECONDS,
json_extract_path_text(from_varbyte(kinesis_data, 'utf-8'),'TX_TIME_DAYS')::int as TX_TIME_DAYS
FROM custpaytxn."cust-payment-txn-stream"
Where is_utf8(kinesis_data) AND can_json_parse(kinesis_data);
