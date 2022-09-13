create function delete_salon(_salon_id int) returns
varchar(50) as
'begin
if(select count(id) from salons where salons.id=_salon_id)=0
then return ''Error!'';
end if;
delete from sellers where sellers.id_salon=_salon_id;
delete from stats_recomend where stats_recomend.id_salon=_salon_id;
delete from salons where salons.id=_salon_id;
return ''Success!!'';
end;'
language 'plpgsql';