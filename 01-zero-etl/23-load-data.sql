--- For PDX (us-west-2, Oregon) region, please use below load scripts:
use demodb;
LOAD DATA FROM S3 PREFIX 's3://redshift-immersionday-labs/ri2023/ant307/data/order-line/region/' INTO TABLE region FIELDS TERMINATED BY '|';          
LOAD DATA FROM S3 PREFIX 's3://redshift-immersionday-labs/ri2023/ant307/data/order-line/nation/' INTO TABLE nation FIELDS TERMINATED BY '|';            
LOAD DATA FROM S3 PREFIX 's3://redshift-immersionday-labs/ri2023/ant307/data/order-line/supplier/' INTO TABLE supplier FIELDS TERMINATED BY '|';            
LOAD DATA FROM S3 PREFIX 's3://redshift-immersionday-labs/ri2023/ant307/data/order-line/customer/' INTO TABLE customer FIELDS TERMINATED BY '|';            
LOAD DATA FROM S3 PREFIX 's3://redshift-immersionday-labs/ri2023/ant307/data/order-line/orders/' INTO TABLE orders FIELDS TERMINATED BY '|';            
LOAD DATA FROM S3 PREFIX 's3://redshift-immersionday-labs/ri2023/ant307/data/order-line/lineitem/' INTO TABLE lineitem FIELDS TERMINATED BY '|';            
LOAD DATA FROM S3 PREFIX 's3://redshift-immersionday-labs/ri2023/ant307/data/order-line/part/' INTO TABLE part FIELDS TERMINATED BY '|';            
LOAD DATA FROM S3 PREFIX 's3://redshift-immersionday-labs/ri2023/ant307/data/order-line/partsupp/' INTO TABLE partsupp FIELDS TERMINATED BY '|';        
