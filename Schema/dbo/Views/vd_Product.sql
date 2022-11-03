

CREATE view [dbo].[vd_Product] as
select
	P.ProductID,
	P.ProductName,
	P.QuantityPerUnit,
	P.UnitPrice,
	P.UnitsInStock,
	P.UnitsOnOrder,
	P.ReorderLevel,
	P.Discontinued,
	G.CategoryID as [Category],
	G.CategoryName,
	G.[Description],
	S.SupplierID as [Supplier],
	S.CompanyName as [SupplierName],
	S.ContactName,
	S.ContactTitle
from Products P
	inner join Categories G on P.CategoryID = G.CategoryID
	inner join Suppliers S on P.SupplierID = S.SupplierID