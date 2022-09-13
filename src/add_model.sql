create function add_model(_name varchar(255), 
_price int, _country_id int) returns varcharr(255) as ' begin
if (select count(id) from models where name=_name and
price=_price) > 0 then
return ''model_price_error'';
end if;
insert into models values(default, _name, _price, _country_id);

return ''success'';
end;'
language 'plpgsql';