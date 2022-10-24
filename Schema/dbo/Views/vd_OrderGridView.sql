
CREATE view [dbo].[vd_OrderGridView]
as
select
	O.OrderID,
	O.CustomerID,
	O.OrderDate,
	O.ShipName,
	S.ShipperID,
	S.CompanyName as [Shipper],
	O.ShipRegion,
	O.ShipCountry,
	O.ShipCity,
	O.ShipPostalCode,
	O.ShipAddress,
	O.ShippedDate,
	E.LastName + ',' + E.FirstName as [Employee],
	E.Title as [JobTitle],
	C.Region,
	C.Country,
	C.City,
	C.PostalCode,
	C.[Address]
from Orders O
	inner join Employees E on O.EmployeeID = E.EmployeeID
	inner join Shippers S on O.ShipVia = S.ShipperID
	inner join Customers C on O.CustomerID = C.CustomerID