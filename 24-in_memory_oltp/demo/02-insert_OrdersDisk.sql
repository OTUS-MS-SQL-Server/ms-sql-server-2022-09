USE WideWorldImporters;
GO

DECLARE @RowCount INT = 50000;

DECLARE @i INT = 1;  
BEGIN TRAN;
  WHILE @i <= @RowCount  
  BEGIN;  
    INSERT INTO Sales.OrdersDisk
    (OrderLineID, OrderId, StockItemID, Quantity) 
    VALUES (@i, @i, @i, @i*10);  
    SET @i += 1;  
  END;  
COMMIT;
GO
  
-- ��������, ��� ������ ����������
SELECT COUNT(*) FROM Sales.OrdersDisk;
GO

-- ����� �������� ���������
CREATE OR ALTER PROCEDURE Sales.OrdersDisk_Insert
    @RowCount INT 
AS   
BEGIN      
  
  DECLARE @i INT = 1;  
  WHILE @i <= @RowCount  
  BEGIN;  
    INSERT INTO Sales.OrdersDisk
    (OrderLineID, OrderId, StockItemID, Quantity) 
    VALUES (@i, @i, @i, @i*10);  
    SET @i += 1;  
  END;  
END;
GO

-- ������� �������
DELETE FROM Sales.OrdersDisk
GO

-- ���������
SELECT COUNT(*) FROM Sales.OrdersDisk;
GO

-- ��������� �������� ���������
EXEC Sales.OrdersDisk_Insert @RowCount = 50000;

-- ���������
SELECT COUNT(*) FROM Sales.OrdersDisk_Insert;
GO


