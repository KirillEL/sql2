create function f_stats_recomend(_id_model int, _id_salon
int) returns varchar(255) as '
begin 
if (select count(id) from stats_recomend where id_model=_id_model 
and id_salon) > 0 then
update stats_recomend set rating = * where id_model=_id_model 
and id_salon;
else
insert into stats_recomend values (default, _id_model, 
_id_salon, *);
end if;
return ''success'';
end'
language 'plpgsql';