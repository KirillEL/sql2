create function sell_car(model_id int, manager_id int)
returns varchar(50) as
'
  declare market_id int;
  declare m int;
  declare cnt int;
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
  return ''Success!!'';
  end;'
  language 'plpgsql';