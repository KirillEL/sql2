create function f_stats_sales(_id_country int) 
returns varchar(255) as '
begin
if ( select count(id) from stats_sales where 
id_country=_id_country ) > 0 then
update stats_sales set sales=(sales+1) where 
id_country=_id_country;
else 
insert into stats_sales values(default, _id_country, 1);
end if;
return ''success'';
end '
language 'plpgsql';