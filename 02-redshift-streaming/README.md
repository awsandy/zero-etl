A Kinesis Data Stream - cust-payment-txn-stream
An EventBridge rule - ant307-zeroetl-EventRule
A Lambda function - GenStreamData-ant307-zeroetl

---

Eventbridge - rules - ant307-zeroetl-EventRule - `Enable`
(triggers Lambda every minute)

Kinesis - Data Streams - cust-payment-txn-stream - `Monitoring` tab

allow ~20 mins data

Eventbridge - rules - ant307-zeroetl-EventRule - `Disbale`

-----

Redshift - Query Editor 2 - Query Data - Configure Account

`Database username and password`
Dev / awsuser / Awsuser123 `Create connection`
