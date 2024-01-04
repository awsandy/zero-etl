select '1. region' as tablename,count(*) from demodb.region union
select '2. nation',count(*) from demodb.nation union
select '3. supplier', count(*) from demodb.supplier union
select '4. customer', count(*) from demodb.customer union
select '5. orders',count(*) from demodb.orders union
select '6. lineitem',count(*) from demodb.lineitem union
select '7. part',count(*) from demodb.part union
select '8. partsupp',count(*) from demodb.partsupp order by 1;
