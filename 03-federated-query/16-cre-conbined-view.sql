CREATE VIEW ant307_view_cust_payment_tx AS
  SELECT * FROM ant307_das.cust_payment_tx_202301
  UNION ALL
  SELECT * FROM ant307_external.cust_payment_tx_history
WITH NO SCHEMA BINDING;
