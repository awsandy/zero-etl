##
echo "RDS Integrations"
aws rds describe-integrations

srcid=$(aws rds describe-db-clusters | jq -r '.DBClusters[] | select(.Engine=="aurora-mysql").DBClusterIdentifier')
srcarn=$(aws rds describe-db-clusters | jq -r '.DBClusters[] | select(.Engine=="aurora-mysql").DBClusterArn')
#aws redshift describe-clusters --query 'Clusters[].ClusterIdentifier' --output text
tgtrs=$(aws redshift-serverless list-workgroups --query 'workgroups[].workgroupName' --output text)
tgtarn=$(aws redshift-serverless list-namespaces --query 'namespaces[].namespaceArn' --output text)
echo "Source = $srcid"
echo "Target = $tgtrs"

# set integration source ant307-zeroetl-sourceamscluster-1hub5xk8xp1e0 - mysql
#  zero-etl-destination-dw-ns-f0999c00   redshift serverless

# create integration
aws rds create-integration --source-arn $srcarn --target-arn $tgtarn --integration-name zero-etl-serverless
aws rds describe-integrations