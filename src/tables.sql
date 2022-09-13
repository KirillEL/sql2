create database dealership;

\c dealership;

create table country(
  id serial primary key,
  name varchar(255)
);

create table salons(
  id serial primary key,
  name varchar(255),
  address varchar(255)
);

create table models(
  id serial primary key,
  name varchar(255),
  price integer,
  country_id int references country(id)
);

create table sellers(
  id serial primary key,
  name varchar(255),
  id_salon integer references salons(id)
);

create table sales(
  id serial primary key,
  id_model integer references models(id),
  id_seller integer references sellers(id),
  nonresident varchar(255) 
);

alter table sales add constraint
check_resident check(nonresident='yes' or
nonresident='no');


create table Availability(
  id serial primary key,
  id_model int references models(id),
  id_salon int references salons(id),
  amount int
);

create table stats_seller(
  id serial primary key,
  id_seller int references sellers(id),
  id_model int references models(id),
  sold int
);

create table stats_recomend(
  id serial primary key,
  id_model int references models(id),
  id_salon int references salons(id),
  rating int
);

create table stats_sales(
  id serial primary key,
  id_country int unique references country(id),
  sales int
);

create table stats_resident(
  resident int default 0,
  nonresident int default 0,
  year int
);

insert into stats_resident values (0,0, 2022);

create table stats_price(
  id serial primary key,
  id_country int uniqreferences country(id),
  min_price int,
  avg_price int,
  max_price int
);