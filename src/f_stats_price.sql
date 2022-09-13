create function f_stats_price(_id_country int, price int) 
returns varchar(255) as '
begin
if (select count(id) from stats_price where 
id_country=_id_country) > 0 then
if (select min_price from stats_price where 
id_country=_id_country) > price then
update stats_price set min_price=price where
id_country=_id_country;
end if;
if (select max_price from stats_price where 
id_country=_id_country) < price then
update stats_price set max_price=price where
id_country=_id_country;
end if;
update stats_price set avg_price = (select avg(price)
from models where country_id=_id_country);
else 
insert into stats_price values (default, _id_country,
price, price, price);
'