## Setup Zero-ETL source

Check setup (Already Done)

RDS - Parameter Groups - ant307*
Edit
Actions - reboot

----

## Setup Zero-ETL Target

TODO:

Redshift - Serverless dashbord - zero-etl namespace
Resource Policy tab

Authorized Principal - ARN User or Role - or Account ID
Authorized Integration Sources - ARN Arora MySQL DB Cluster
( get form RDS, Databases, ant307* - Configuration Tab)

-----

(Already Done)
set to enable case sensitive 

aws redshift-serverless update-workgroup --workgroup-name redshift_serverless_workgroup_name --config-parameters parameterKey=enable_case_sensitive_identifier,parameterValue=true --region us-east-1

----

## Configure security - IAM

IAM (Already Done)

rds-integrations policy - rds:CreateIntegration, rds:DeleteIntegration, rds:CreateInboundIntegration

Roel in target account :
redshift:DescribeClusters., redshoft-serverless: ListNamespaces

trust - allow sts:AssumeRole - arn:aws:iam::xxxxxxxxxx::root

-----

## Create Zero-ETL Integration

RDS - Zero-ETL Integration - `Create Zero ETL Integration`
enter zero-etl-serverless - next
Source - Browse RDS databses - (aurora mySQL ant307*)
Target - Use current account - Browse RedShift data warehouses - (zero-etl-destination)
Add Tags and encryption - Next
`Create zero-ETL integration`

(takes 15-20 mins to create)


-----

Redshift - Query Editor v2 - Query Data
Create Connection
`Database username and password`
Dev / awsuser / Awsuser123 `Create connection`

11-query-integration.sql
12-create-db-from-integration.sql

----

## Validations and Monitoring


### Check:
RDS - Paramters - zero-etl-custom-pg
aws_default_s3_role --> should be ...   demo_rds_s3_role

RDS - Databases - cluster - zero-etl-source



RDS - Databases - ant307 (Writer instance) 
Connectivity and Security tab - get endpoint

In EC2:
EC2 - ec2-rds-client  `Connect` - SSM
Connectivity and Security
`Select IAM roles to add to this cluster`
`demo_rds_s3_role`
`Add Role`


21-mysql-login.sql
22-cre-tables.sql
23-load-data.sql



---

Redshift - Query Editor v2 - Query Data
Create Connection
`Database username and password`
Dev / awsuser / Awsuser123 `Create connection`

31-select-demodb.sql

----

41-grant-monotor.sql

Redshift
Zero-ETL Integrations - 
Integration Metrics tab
Table Statistics tab








