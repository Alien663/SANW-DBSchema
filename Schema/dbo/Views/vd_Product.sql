
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
	G.CategoryID,
	G.CategoryName,
	G.[Description],
	S.SupplierID,
	S.CompanyName as [Supplier],
	S.ContactName,
	S.ContactTitle
from Products P
	inner join Categories G on P.CategoryID = G.CategoryID
	inner join Suppliers S on P.SupplierID = S.SupplierID