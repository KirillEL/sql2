create function delete_model(_model_id int) returns
varchar(50) as
'begin
if(select count(id) from models where models.id=_model_id)=0 then
return ''Error!!'';
end if;
delete from models where models.id=_model_id;
delete from stats_seller where stats_seller.id_model=_model_id;
delete from stats_recomend where stats_recomend.id_model=_model_id;
return ''success!'';
end;'
language 'plpgsql';