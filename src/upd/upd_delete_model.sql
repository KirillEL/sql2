create or replace function delete_model(_model_id int) returns
varchar(50) as'
declare _id_country int;
begin
select country_id into _id_country from models where models.id = _model_id;
if(select count(id) from models where models.id=_model_id)=0 then
return ''Error!!'';
end if;
delete from stats_seller where stats_seller.id_model=_model_id;
delete from stats_recomend where stats_recomend.id_model=_model_id;
delete from sales where id_model = _model_id;
delete from availability where id_model=_model_id;
delete from models where models.id=_model_id;
--                                      **f_stats_price переделанная для удаления**
if (select count(id) from models where country_id=_id_country) = 0 then
delete from stats_price where id_country =_id_country;
else
update stats_price set min_price = (select min(price) from models where country_id=_id_country);
update stats_price set max_price = (select max(price) from models where country_id=_id_country);
update stats_price set avg_price = (select avg(price) from models where country_id=_id_country);
end if;
--
return ''success!'';
end;'
language 'plpgsql';