create or replace function add_car(_id_model int, _id_salon int, 
_amount int) returns VARCHAR(255) as '
declare amnt int;
begin 
if _amount < 0 then 
return ''num_error'';
end if;
if (select count(id) from salons where 
id=_id_salon)=0 then 
return ''salon_error'';
end if;
if (select count(id) from models where
id=_id_model)=0 then 
return ''model_error'';
end if;
select amount into amnt from Availability where
id_model=_id_model and id_salon=_id_salon;
if amnt > 0 then
update Availability set amount = (amnt + _amount)
where id_model=_id_model and id_salon=_id_salon;
else 
insert into Availability values(default,
_id_model, _id_salon, _amount);
end if;
--                      **f_stats_recomend**
if (select count(id) from stats_seller where id_model=_id_model) > 0 then
if (select count(id) from stats_recomend where id_model=_id_model 
and id_salon = _id_salon) > 0 then
update stats_recomend set rating = ((select amount from Availability where id_model=_id_model
and id_salon = _id_salon) * (select sum(sold) from
stats_seller where id_model=_id_model)) where id_model=_id_model 
and id_salon=_id_salon;
else
insert into stats_recomend values (default, _id_model, 
_id_salon, ((select amount from Availability where id_model=_id_model
and id_salon = _id_salon) * (select sum(sold) from
stats_seller where id_model=_id_model)) ); 
end if;
else
if (select count(id) from stats_recomend where id_model=_id_model 
and id_salon=_id_salon) > 0 then
update stats_recomend set rating = _amount where id_model=_id_model 
and id_salon;
else
insert into stats_recomend values (default, _id_model, 
_id_salon, _amount ); 
end if;
end if;
-- * как вычислить рейтинг хз

return ''success '';
end;'
language 'plpgsql'; 