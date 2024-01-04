


s3://redshift-immersionday-labs/ri2023/ant307/data/cust_payment_tx_history/

https://s3.console.aws.amazon.com/s3/buckets/redshift-demos?region=us-west-2&prefix=ri2023/ant307/data/cust_payment_tx_history/


Glue - run cust_payment_tx_history crawler

get table:  cust_payment_tx_history


Redshift serverless `Query data`
 https://us-west-2.console.aws.amazon.com/redshiftv2/home?region=us-west-2#/serverless-setup 



./11-

./17-

----

Get (stack output) values: AuroraPostgresEndpoint & AuroraPostgresSecretArn

Redshift serverless
zero-etl-destination-   namespace
 `Query Editor v2`

 `Database username and password`
Dev / awsuser / Awsuser123 `Create connection`

-----

Optional

RDS dashboard - `Query editor`

aurorapg-
Connect with secrets manager ARN
arn:aws:secretsmanger: 
postgres

then:
select * from public.customer_info;







