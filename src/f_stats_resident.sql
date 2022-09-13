create function f_stats_resident(nonres varchar(255)) returns
varchar(255) as '
begin
if (nonres = ''yes'') then 
update stats_resident set nonresident=(nonresident + 1);
else 
update stats_resident set resident=(resident + 1);
'