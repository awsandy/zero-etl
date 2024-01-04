select '1. region' as tablename,count(*) from aurora_zeroetl.demodb.region union
select '2. nation',count(*) from aurora_zeroetl.demodb.nation union
select '3. supplier', count(*) from aurora_zeroetl.demodb.supplier union
select '4. customer', count(*) from aurora_zeroetl.demodb.customer union
select '5. orders',count(*) from aurora_zeroetl.demodb.orders union
select '6. lineitem',count(*) from aurora_zeroetl.demodb.lineitem union
select '7. part',count(*) from aurora_zeroetl.demodb.part union
select '8. partsupp',count(*) from aurora_zeroetl.demodb.partsupp order by 1;
