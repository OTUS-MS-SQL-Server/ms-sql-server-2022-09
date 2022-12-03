use WideWorldImporters;

exec Sales.OrdersMem_Insert @rowcount = 500000;
--delete from Sales.OrdersMem;
--delete from Sales.OrdersMem2;

SELECT COUNT(*)
FROM Sales.OrdersMem;

---не работает для Memory Optimized tables

MERGE 
 [Sales].[OrdersMem]  AS target 
USING (SELECT 20 AS OrderLineId, 20 AS OrderId, 20 AS StockItem, 200 AS Quantity)
	AS source (OrderLineId, OrderId, [StockItemID], Quantity)
	ON (target.OrderLineId = source.OrderLineId)
WHEN MATCHED 
		THEN UPDATE SET
			Quantity = Source.Quantity
WHEN NOT MATCHED 
		THEN INSERT
		(OrderLineID, OrderId, StockItemID, Quantity) 
		VALUES (Source.OrderLineID, Source.OrderId, Source.StockItemID, Source.Quantity)
OUTPUT deleted.*, $action, inserted.*;

MERGE 
 [Sales].[OrdersDisk]  AS target 
USING (SELECT *
FROM [Sales].[OrdersMem]
WHERE OrderLineId = 200)
	AS source (OrderLineId, OrderId, [StockItemID], Quantity)
	ON (target.OrderLineId = source.OrderLineId)
WHEN MATCHED 
		THEN UPDATE SET
			Quantity = Source.Quantity
WHEN NOT MATCHED 
		THEN INSERT
		(OrderLineID, OrderId, StockItemID, Quantity) 
		VALUES (Source.OrderLineID, Source.OrderId, Source.StockItemID, Source.Quantity)
OUTPUT deleted.*, $action, inserted.*;

/*
	UPDATE Sales.OrdersMem
	SET Quantity = 50; 
*/

--
--DELETE FROM Sales.OrdersMem;