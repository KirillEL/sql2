create function hi_world() returns varchar(50) as
'begin
  return ''Hello world!!!'';
  end;'
  language 'plpgsql';



create function say_hi() returns function as
'begin
return (select hi_world());
end;'
language 'plpgsql';