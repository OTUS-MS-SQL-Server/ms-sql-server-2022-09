/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.2014)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [WideWorldImporters]
GO
/****** Object:  StoredProcedure [dbo].[CustomerSearch_KitchenSink]    Script Date: 5/18/2019 7:57:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CustomerSearch_KitchenSink]
  @CustomerID            int            = NULL,
  @CustomerName          nvarchar(100)  = NULL,
  @BillToCustomerID      int            = NULL,
  @CustomerCategoryID    int            = NULL,
  @BuyingGroupID         int            = NULL,
  @MinAccountOpenedDate  date           = NULL,
  @MaxAccountOpenedDate  date           = NULL,
  @DeliveryCityID        int            = NULL,
  @IsOnCreditHold        bit            = NULL
WITH RECOMPILE
AS
BEGIN
  SET NOCOUNT ON;
 
  SELECT CustomerID, CustomerName, IsOnCreditHold
  FROM Sales.Customers
  WHERE (@CustomerID IS NULL 
         OR CustomerID = @CustomerID)
    AND (@CustomerName IS NULL 
         OR CustomerName LIKE @CustomerName)
    AND (@BillToCustomerID IS NULL 
         OR BillToCustomerID = @BillToCustomerID)
    AND (@CustomerCategoryID IS NULL 
         OR CustomerCategoryID = @CustomerCategoryID)
    AND (@BuyingGroupID IS NULL 
         OR BuyingGroupID = @BuyingGroupID)
    AND AccountOpenedDate >= 
        COALESCE(@MinAccountOpenedDate, AccountOpenedDate)
    AND AccountOpenedDate <= 
        COALESCE(@MaxAccountOpenedDate, AccountOpenedDate)
    AND (@DeliveryCityID IS NULL 
         OR DeliveryCityID = @DeliveryCityID)
    AND (@IsOnCreditHold IS NULL 
         OR IsOnCreditHold = @IsOnCreditHold)
	--OPTION (RECOMPILE)
	;

END