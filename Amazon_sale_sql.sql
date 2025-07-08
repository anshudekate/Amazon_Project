create table amazon(
index int,
Order_ID int,
Date date,
Status varchar,
Fulfilment varchar,
Sales_Channel  varchar,
ship_service_level varchar,
Style varchar,
SKU varchar,
Category varchar,
Size varchar,
ASIN varchar,
Courier_Status varchar,
Qty int,
currency varchar,
Amount numeric,
ship_city varchar,
ship_state varchar,
ship_postal_code int,
ship_country varchar,
B2B varchar,
fulfilled_by varchar
)


copy amazon from 'D:\project\Amazon Sale Report.csv' DELIMITER ',' csv header;



select * from amazon


select status , sales_channel, sum(amount) as Price  
from amazon group by status , sales_channel


create table amazon_status as 
select index , order_id , status , fulfilment , sales_channel , ship_service_level courier_status, date,
ship_city , ship_state , ship_postal_code from amazon


create table amazon_category as 
select index , style , category , size , qty , currency , amount  from amazon 


select status , sum(amount)as Amount from amazon_status as s
inner join amazon_category as c
on s.index = c.index 
group by status

select category , sum(amount) as Amount from amazon_status as s
inner join amazon_category as c
on s.index = c.index 
group by category	



select size , sum(amount) as Amount from amazon_status as s
inner join amazon_category as c
on s.index = c.index 
group by size


create view  city_amount  as
select qty , category , size ,amount, ship_city , sum(amount) over (partition by ship_city) as City_amount from amazon_status as s
inner join amazon_category as c
on s.index = c.index 
