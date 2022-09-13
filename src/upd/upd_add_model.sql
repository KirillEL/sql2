create or replace function add_model(_name varchar(255), 
_price int, _id_country int) returns varchar(255) as ' begin
if (select count(id) from models where name=_name and
price=_price) > 0 then
return ''model_price_error'';
end if;
insert into models values(default, _name, _price, _id_country);
--                        **f_stats_price**
if (select count(id) from stats_price where 
id_country=_id_country) > 0 then
if (select min_price from stats_price where 
id_country=_id_country) > _price then
update stats_price set min_price=_price where
id_country=_id_country;
end if;
if (select max_price from stats_price where 
id_country=_id_country) < _price then
update stats_price set max_price=_price where
id_country=_id_country;
end if;
update stats_price set avg_price = (select avg(price)
from models where country_id=_id_country);
else 
insert into stats_price values (default, _id_country,
_price, _price, _price);
end if;
--
return ''success'';
end;'
language 'plpgsql';