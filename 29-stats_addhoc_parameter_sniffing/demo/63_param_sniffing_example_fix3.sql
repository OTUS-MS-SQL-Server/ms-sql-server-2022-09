/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.2002)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [WideWorldImporters]
GO
/****** Object:  StoredProcedure [Sales].[GetInvoiceMetricsByBillToCustomerID]    Script Date: 5/4/2019 9:16:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [Sales].[GetInvoiceMetricsByBillToCustomerID]
	@BillToCustomerID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		si.CustomerID,
		si.BillToCustomerID,
		si.InvoiceID,
		si.InvoiceDate,
		si.ConfirmedDeliveryTime,
		si.IsCreditNote
	FROM Sales.Invoices AS si
	WHERE si.BillToCustomerID = @BillToCustomerID
	OPTION (RECOMPILE);
END

