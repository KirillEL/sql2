create function f_stats_seller(_id_seller int, 
_id_model int) returns varchar(255) as ' begin
if (count(id) from stats_seller where id_seller=_id_seller
and id_model = _id_model) > 0 then 
update f_stats_seller set sold=(sold+1) where id_seller=_id_seller
and id_model = _id_model;
else 
insert into stats_seller values(default, _id_seller,
_id_model, 1);
end if;
return ''success''
end'
language 'plpgsql';