USE WideWorldImporters;
GO

DELETE FROM Sales.OrdersMemory_SCHEMA_AND_DATA
GO

DECLARE @RowCount INT = 50000;

DECLARE @i INT = 1;  
BEGIN TRAN;
  WHILE @i <= @RowCount  
  BEGIN;  
    INSERT INTO Sales.OrdersMemory_SCHEMA_AND_DATA
    (OrderLineID, OrderId, StockItemID, Quantity) 
    VALUES (@i, @i, @i, @i*10);  
    SET @i += 1;  
  END;  
COMMIT;
GO
 
-- ��������, ��� ������ ����������
SELECT COUNT(*) FROM Sales.OrdersMemory_SCHEMA_AND_DATA;
GO

-- �������� ��
CREATE OR ALTER PROCEDURE Sales.OrdersMemory_SCHEMA_AND_DATA_Insert_Native
    @RowCount INT 
WITH NATIVE_COMPILATION, SCHEMABINDING 
AS   
BEGIN ATOMIC   
  WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english')  
  
  DECLARE @i INT = 1;  
  WHILE @i <= @RowCount  
  BEGIN;  
    INSERT INTO Sales.OrdersMemory_SCHEMA_AND_DATA
    (OrderLineID, OrderId, StockItemID, Quantity) 
    VALUES (@i, @i, @i, @i*10);  
    SET @i += 1;  
  END;  
END;
GO

-- ������� ��
CREATE OR ALTER PROCEDURE Sales.OrdersMemory_SCHEMA_AND_DATA_Insert
    @RowCount INT 
AS   
BEGIN   
  DECLARE @i INT = 1;  
  WHILE @i <= @RowCount  
  BEGIN;  
    INSERT INTO Sales.OrdersMemory_SCHEMA_AND_DATA
    (OrderLineID, OrderId, StockItemID, Quantity) 
    VALUES (@i, @i, @i, @i*10);  
    SET @i += 1;  
  END;  
END;
GO

-- --------------------------
-- ������� ��
-- --------------------------
-- ������� �������
DELETE FROM Sales.OrdersMemory_SCHEMA_AND_DATA
GO

-- ���������
SELECT COUNT(*) FROM Sales.OrdersMemory_SCHEMA_AND_DATA;
GO

-- ��������� �������� ���������
EXEC Sales.OrdersMemory_SCHEMA_AND_DATA_Insert @RowCount = 50000;

-- ���������
SELECT COUNT(*) FROM Sales.OrdersMemory_SCHEMA_AND_DATA;
GO

-- --------------------------
-- �������� ��
-- --------------------------
-- ������� �������
DELETE FROM Sales.OrdersMemory_SCHEMA_AND_DATA
GO

-- ���������
SELECT COUNT(*) FROM Sales.OrdersMemory_SCHEMA_AND_DATA;
GO

-- ��������� �������� ���������
EXEC Sales.OrdersMemory_SCHEMA_AND_DATA_Insert_Native @RowCount = 50000;

-- ���������
SELECT COUNT(*) FROM Sales.OrdersMemory_SCHEMA_AND_DATA;
GO