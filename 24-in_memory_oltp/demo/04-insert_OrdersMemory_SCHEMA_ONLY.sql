USE WideWorldImporters;
GO

DELETE FROM Sales.OrdersMemory_SCHEMA_ONLY
GO

DECLARE @RowCount INT = 50000;

DECLARE @i INT = 1;  
BEGIN TRAN;
  WHILE @i <= @RowCount  
  BEGIN;  
    INSERT INTO Sales.OrdersMemory_SCHEMA_ONLY
    (OrderLineID, OrderId, StockItemID, Quantity) 
    VALUES (@i, @i, @i, @i*10);  
    SET @i += 1;  
  END;  
COMMIT;
GO
 
-- ��������, ��� ������ ����������
SELECT COUNT(*) FROM Sales.OrdersMemory_SCHEMA_ONLY;
GO

-- �������� ��
CREATE OR ALTER PROCEDURE Sales.OrdersMemory_SCHEMA_ONLY_Insert
    @RowCount INT 
WITH NATIVE_COMPILATION, SCHEMABINDING 
AS   
BEGIN ATOMIC   
  WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english')  
  
  DECLARE @i INT = 1;  
  WHILE @i <= @RowCount  
  BEGIN;  
    INSERT INTO Sales.OrdersMemory_SCHEMA_ONLY
    (OrderLineID, OrderId, StockItemID, Quantity) 
    VALUES (@i, @i, @i, @i*10);  
    SET @i += 1;  
  END;  
END;
GO

-- ������� �������
DELETE FROM Sales.OrdersMemory_SCHEMA_ONLY
GO

-- ���������
SELECT COUNT(*) FROM Sales.OrdersMemory_SCHEMA_ONLY;
GO

-- ��������� �������� ���������
EXEC Sales.OrdersMemory_SCHEMA_ONLY_Insert @RowCount = 50000;

-- ���������
SELECT COUNT(*) FROM Sales.OrdersMemory_SCHEMA_ONLY;
GO