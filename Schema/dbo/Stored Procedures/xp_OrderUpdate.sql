

CREATE procedure [dbo].[xp_OrderUpdate]
	@OrderID int,
	@shipper int,
	@CustomerID varchar(5),
	@OrderDate datetime,
	@ShipName nvarchar(40),
	@ShipRegion nvarchar(15),
	@ShipCountry nvarchar(15),
	@ShipCity nvarchar(15),
	@ShipPostalCode nvarchar(10),
	@ShipAddress nvarchar(60),
	@ShippedDate datetime
as
begin
    set nocount on;
    declare @trancount int;
    set @trancount = @@trancount;
    begin try
        if @trancount = 0
            begin transaction
        else
            save transaction usp_my_procedure_name;

		if exists(select * from Customers where CustomerID = @CustomerID)
			update Orders
				set CustomerID = @CustomerID, OrderDate = @OrderDate, ShipName = @ShipName,
					ShipRegion = @ShipRegion, ShipCountry = @ShipCountry, ShipCity = @ShipCity,
					ShipPostalCode = @ShipPostalCode, ShipAddress = @ShipAddress, ShippedDate = @ShippedDate,
					ShipVia = @shipper
				where OrderID = @OrderID
		else
			raiserror('Customer is not exists', 18, 2)

        if @trancount = 0   
            commit;
    end try
    begin catch
        declare @error int, @message varchar(4000), @xstate int;
        select @message = ERROR_MESSAGE(), @xstate = XACT_STATE();
        if @xstate = -1
            rollback;
        if @xstate = 1 and @trancount = 0
            rollback
        if @xstate = 1 and @trancount > 0
            rollback transaction usp_my_procedure_name;
        raiserror (@message, 16, 1);
    end catch   
end