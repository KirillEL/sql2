create function add_seller (_id_salon int, _name varchar(255))
returns varchar(255) as '
begin
if (select count(id) from salons where 
id=_id_salon)=0 then 
return ''salon_error'';
end if;
insert into sellers values(default, _name, 
_id_salon);
return ''success'';
end;'
language 'plpgsql';