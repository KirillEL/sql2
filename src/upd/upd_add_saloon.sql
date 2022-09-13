create function add_salon(_name varchar(255), 
_address varchar(255)) returns varchar(255) as 'begin
if (select count(id) from salons where name=_name and 
address=_address) > 0 then
return ''name_address_error'';
end if;
insert into salons values(default, _name, _address);
return ''success'';
end;'
language 'plpgsql';