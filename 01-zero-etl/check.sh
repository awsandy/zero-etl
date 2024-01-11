echo "SourceARN is rds zero-etl"
aws rds describe-integrations --query 'Integrations[].SourceArn' | grep ant307-zeroetl- | grep rds
echo "TargetArn is rds zero-etl"
aws rds describe-integrations --query 'Integrations[].TargetArn' | grep redshift-serverless | grep namespace
