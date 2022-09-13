create or replace function sell_car(model_id int, manager_id int, _nonres varchar(255))
returns varchar(50) as
'
  declare market_id int;
  declare m int;
  declare cnt int;
  declare _id_country int;
  begin
  if(select count(id) from models where id=model_id)=0 then return ''Error!'';
  end if;
  select id_salon into market_id from sellers where manager_id=id;
  select count(id_model) into cnt from
  availability where id_salon=market_id and model_id=availability.id_model;
  if cnt=0 then return ''error count=0'';
  end if;
  if (select amount from availability where id_model=model_id and id_salon=market_id)=1
  then
  delete from availability where id_model=model_id and id_salon=market_id;
  else
  update availability set amount=amount-1 where
  id_model=model_id and id_salon=market_id;
  end if;
  select max(id) into m from sales;
  insert into sales
  values(default, model_id,manager_id,''yes'');
  --                        **f_stats_recomend**
  if (select count(id) from stats_recomend where id_model=model_id 
and id_salon = market_id) > 0 then
update stats_recomend set rating = ((select amount from Availability where id_model=model_id
and id_salon = market_id) * (select sum(sold) from
stats_seller where id_model=model_id)) where id_model=model_id 
and id_salon=market_id;
else
insert into stats_recomend values (default, model_id, 
market_id, ((select amount from Availability where id_model=model_id
and id_salon = market_id) * (select sum(sold) from
stats_seller where id_model=model_id)) ); 
end if;
  -- * рейтинг              **f_stats_resident**
  if (_nonres = ''yes'') then 
  update stats_resident set nonresident=(nonresident + 1) where year=2022;
  else 
  update stats_resident set resident=(resident + 1) where year = 2022; 
  end if;
  --                        **f_stats_seller**
  if (select count(id) from stats_seller where id_seller= manager_id
  and id_model = model_id) > 0 then 
  update stats_seller set sold=(sold+1) where id_seller= manager_id
  and id_model = model_id;
  else 
  insert into stats_seller values(default, manager_id,
  model_id, 1);
  end if;
  --                        **f_stats_sales**
  select country_id into _id_country from models where id = model_id;
  if ( select count(id) from stats_sales where 
  id_country=_id_country ) > 0 then
  update stats_sales set sales=(sales+1) where 
  id_country=_id_country;
  else 
  insert into stats_sales values(default, _id_country, 1);
  end if;
  --
  return ''Success!!'';
  end;'
  language 'plpgsql';