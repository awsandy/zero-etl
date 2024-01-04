CREATE EXTERNAL SCHEMA postgres
FROM POSTGRES
DATABASE 'postgres'
URI '[replace with aurora postgres endpoint - AuroraPostgresEndpoint]'
IAM_ROLE default
SECRET_ARN '[replace with aurora postgres secret arn - AuroraPostgresSecretArn]'
