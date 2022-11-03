
CREATE procedure [dbo].[xp_ProductUpdate]
	@ProductID int,
	@Supplier int,
	@Category int,
	@ProductName nvarchar(40),
	@QuantityPerUnit nvarchar(20),
	@UnitPrice money,
	@UnitsInStock smallint,
	@UnitsOnOrder smallint,
	@ReorderLevel smallint,
	@Discontinued bit
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

		update Products
			set ProductName = @ProductName, QuantityPerUnit = @QuantityPerUnit,
				UnitPrice = @UnitPrice, UnitsInStock = @UnitsInStock,
				UnitsOnOrder = @UnitsOnOrder, ReorderLevel = @ReorderLevel,
				Discontinued = @Discontinued, SupplierID = @Supplier, CategoryID = @Category
			where ProductID = @ProductID

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