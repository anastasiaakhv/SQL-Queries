SELECT description, category FROM alp_item

SELECT inv_id, item_size, price, quantity_on_hand 
FROM alp_inventory
WHERE price<100

SELECT inv_id, price, quantity_on_hand 
FROM alp_inventory
WHERE quantity_on_hand > 30

SELECT first, last, mi, city
FROM alp_customer
WHERE (city = 'Washburn' OR city = 'Silver Lake')

SELECT DISTINCT price
FROM alp_inventory

SELECT inv_id, price, quantity_on_hand 
FROM alp_inventory
WHERE quantity_on_hand > 0

SELECT order_id, order_date
FROM alp_orders
WHERE order_date < '2007-11-01'

SELECT inv_id, price, quantity_on_hand 
FROM alp_inventory
WHERE ((alp_color = 'Coral' OR alp_color = 'Olive') AND quantity_on_hand < 105)

SELECT item_id, description, category
FROM alp_item
WHERE description like '%Fleece%'

SELECT inv_id, price
FROM alp_inventory
WHERE (item_size is null OR alp_color is null)

SELECT COUNT(order_id) as orderNumber 
FROM alp_orders
WHERE order_date = '2007-10-10'

SELECT order_id, inv_id, (qty*order_price) as extendedPrice
FROM alp_orderline

SELECT order_id, COUNT(*) as numItems 
FROM alp_orderline
GROUP BY order_id

SELECT cust_id, COUNT(*) as numOrders
FROM alp_orders
GROUP BY cust_id
HAVING COUNT(*) > 1

SELECT order_id, (order_price*qty) as orderTotal
FROM alp_orderline
WHERE (order_price*qty)  > 100 
ORDER BY (order_price*qty) ASC;

SELECT MAX(price)
FROM alp_inventory

SELECT MIN(price)
FROM alp_inventory

SELECT AVG(price)
FROM alp_inventory

SELECT * FROM alp_inventory
WHERE price > (SELECT AVG(price) FROM alp_inventory)



