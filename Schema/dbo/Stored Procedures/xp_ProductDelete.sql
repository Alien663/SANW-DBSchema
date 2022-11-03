﻿
create   procedure [dbo].[xp_ProductDelete]
	@ProductID int
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

		if exists(select 1 from [Order Details] where ProductID = @ProductID)
			raiserror('Can not delete this product because it was ordered', 18, 2)
		else
			delete Products where ProductID = @ProductID

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