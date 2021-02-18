-- Cкрипты характерных выборок

-- выборка топ-10 водителей, заработавших больше всего денег
SELECT 
cd.first_name,
cd.last_name,
SUM(ct.cost_trip) as cost_sum
FROM ct_drivers cd
left join ct_trips ct on ct.driver_id = cd.id
group by
cd.first_name,
cd.last_name
order by cost_sum DESC
LIMIT 10;

-- выборка топ-10 водителей, заработавших выполнивших болше всего заказов
SELECT 
cd.first_name,
cd.last_name,
COUNT(ct.id) as trip_done
FROM ct_drivers cd
left join ct_trips ct on ct.driver_id = cd.id
group by
cd.first_name,
cd.last_name
order by trip_done DESC
LIMIT 10;

-- выборка топ-10 водителей, проехавших больше всего км.
SELECT 
cd.first_name,
cd.last_name,
SUM(ct.distance_trip) as dist_count
FROM ct_drivers cd
left join ct_trips ct on ct.driver_id = cd.id
group by
cd.first_name,
cd.last_name
order by dist_count DESC
LIMIT 10;

-- выборка городов по общему кол-ву заказов и по выполненным заказам
SELECT 
cc.city_name,
ord_all.orders as orders_all,
ord_done.orders as orders_done,
(ord_done.orders / ord_all.orders * 100) as percent_of_completion
FROM cat_city cc
left join (select cc.city_name, COUNT(orders.addr_from_id) as orders
FROM cat_city cc 
left join ct_address ca on ca.city_id = cc.id 
left join ct_orders orders on orders.addr_from_id = ca.id
GROUP BY cc.city_name) ord_all on ord_all.city_name = cc.city_name
left join (select cc.city_name, COUNT(orders.addr_from_id) as orders
FROM cat_city cc 
left join ct_address ca on ca.city_id = cc.id 
left join ct_orders orders on orders.addr_from_id = ca.id
where order_is_done = 1
GROUP BY cc.city_name) ord_done on ord_done.city_name = cc.city_name
ORDER BY percent_of_completion DESC;

-- выборка водителей, у который на дату проверки закончилась страховка
SELECT 
cd.first_name,
cd.last_name,
cd.last_name,
cc.city_name,
ci.valid_until
FROM ct_drivers cd 
left join ct_insurance ci on ci.driver_id = cd.id
left join cat_city cc on cc.id = cd.work_city_id
where ci.valid_until <= CURRENT_DATE();