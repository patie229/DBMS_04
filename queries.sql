-- Query 5 a : All work items for customer ' Berger , Franz '
-- Query 5 a : All work items for customer ' Berger , Franz '
-- Ordered by date and item number
-- Ordered by date and item number
SELECT
o.order_no ,
o.date ,
v.plate ,
wi.description ,
wi.hours
FROM customer c
JOIN " order " o ON o.cust_no = c.cust_no
JOIN vehicle v ON v.plate = o.plate
JOIN work_item wi ON wi.order_no = o.order_no
WHERE c.cust_name = 'Berger , Franz'
ORDER BY o.date , wi.item_no ;

-- Query 5 b : Total hours per mechanic for orders in March
2026
SELECT
m.mech_name ,
ROUND ( SUM ( wi.hours ) , 1) AS total_hours ,
COUNT ( DISTINCT wi.order_no ) AS orders
FROM mechanic m
JOIN work_item wi ON wi.mech_id = m.mech_id
JOIN " order " o ON o.order_no = wi.order_no
WHERE o.date LIKE '2026 -03 -%'
GROUP BY m.mech_id , m.mech_name
ORDER BY total_hours DESC ;

-- Query 5c -1 : Vehicles with no repair order ( EXCEPT )
SELECT plate , model FROM vehicle
EXCEPT
SELECT v.plate , v.model
FROM vehicle v
JOIN " order " o ON o.plate = v.plate ;

-- Query 5c -2 : Vehicles with no repair order ( NOT EXISTS )
SELECT v.plate , v.model
FROM vehicle v
WHERE NOT EXISTS (
SELECT 1
FROM " order " o
WHERE o.plate = v.plate
) ;
