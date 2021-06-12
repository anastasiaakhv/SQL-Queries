/*
DROP PROCEDURE IF EXISTS sp_UpdateInventory 
DROP PROCEDURE IF EXISTS sp_InsertOrder 
DROP PROCEDURE IF EXISTS sp_UpdateColor
DROP PROCEDURE IF EXISTS sp_CancelOrder
DROP PROCEDURE IF EXISTS sp_CalcOrderTotal
DROP TRIGGER IF EXISTS tr_updateInventory
*/
  
/* 1 */
CREATE PROCEDURE sp_UpdateInventory @myInvId int, @myQty smallint
AS
UPDATE alp_inventory
SET quantity_on_hand = quantity_on_hand + @myQty
WHERE inv_id = @myInvId
GO

/* 2 */

CREATE PROCEDURE sp_InsertOrder @myDate date, @myPayment varchar(5), @custID int, @orderSource varchar(7)
AS
BEGIN
SET NOCOUNT ON

INSERT INTO alp_orders (order_date, payment, cust_id, alp_ordersource)
VALUES(@myDate, @myPayment, @custID, @orderSource)

END
GO

/* 3 */
CREATE PROCEDURE sp_UpdateColor @oldColor nvarchar(15), @newColor varchar(15)
AS
BEGIN
SET NOCOUNT ON
UPDATE alp_inventory
SET alp_color = @newColor
WHERE alp_color = @oldColor

END
GO

/* Test with the following query */

/* EXEC sp_UpdateColor @oldColor = 'Coral', @newColor = 'Pink';
Select * FROM alp_inventory
WHERE alp_color = 'Pink' OR alp_color = 'Coral' */

/* 4 */
CREATE PROCEDURE sp_CancelOrder @orderID int
AS
BEGIN
SET NOCOUNT ON

DELETE FROM alp_orders
WHERE order_id = @orderID

END
GO

/* 5 */ 

CREATE PROCEDURE sp_CalcOrderTotal @order_id INT, @order_total DECIMAL OUTPUT
AS
BEGIN
SET NOCOUNT ON
SET @order_total = (SELECT SUM(order_price*qty) FROM alp_orderline WHERE alp_orderline.order_id = @order_id ) 

RETURN @order_total
END
GO

/* Trigger */

GO CREATE TRIGGER tr_updateInventory 
ON alp_inventory AFTER 
UPDATE
   AS 
   UPDATE
      alp_shipping 
   SET
      alp_shipping.date_exp = DATEADD(DAY, 7, GETDATE()) 
   WHERE
      inv_id = 
      (
         SELECT
            inv_id 
         FROM
            alp_inventory 
         WHERE
            quantity_on_hand <= 4 
      )
