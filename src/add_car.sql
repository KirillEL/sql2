create function add_car(_id_model int, _id_salon int, 
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
return ''success '';
end;'
language 'plpgsql'; 