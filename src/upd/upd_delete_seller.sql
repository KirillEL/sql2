create function delete_seller(seller_id int) returns
varchar(50) as
'begin
if(select count(id) from sellers where id=seller_id)=0
then return ''Error!!'';
end if;
delete from sales where sales.id_seller=seller_id;
delete from stats_seller where stats.id_seller=$1; --удаление из stats_seller
delete from sellers  where sellers.id=seller_id;
return ''success'';
end;'
language 'plpgsql';