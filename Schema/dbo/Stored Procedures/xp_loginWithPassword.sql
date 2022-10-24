


CREATE procedure [dbo].[xp_loginWithPassword]
	@acc varchar(100),
	@pwd varchar(100),
	@token uniqueidentifier output,
	@refreshtoken uniqueidentifier output
as
begin
set nocount on
	begin try
		
		declare @mid int = (select MID from Member where Account = @acc and [Password] = HASHBYTES('SHA2_256', @pwd + REPLACE(CONVERT(varchar(36), Solt), '-', '')))
		if @mid is null begin
			raiserror('Account or Password is not correct, please check again.', 18, 10)
			return;
		end else begin
			if exists(select 1 from vd_Session where MID = @mid and Expired >= GETDATE())begin
				select top 1 @token=Token, @refreshtoken=RefreshToken from vd_Session where MID = @mid and Expired >= GETDATE()
				return
			end else begin
				select @token = NEWID(), @refreshtoken = NEWID()
				insert into SystemSession(Token, RefreshToken, Expired, MID, [Type])
					values(@token, @refreshtoken, 600, @mid, 1)-- set 10 minutes alive
				return;
			end
		end
	end try
	begin catch
		DECLARE @ErrorMessage As VARCHAR(1000) =
					  CHAR(10)+'錯誤代碼：' + CAST(ERROR_NUMBER() AS VARCHAR)
					+ CHAR(10)+'錯誤訊息：' + ERROR_MESSAGE()
					+ CHAR(10)+'錯誤行號：' + CAST(ERROR_LINE() AS VARCHAR)
					+ CHAR(10)+'錯誤程序名稱：' +	 ISNULL(ERROR_PROCEDURE(),'')
		raiserror(@ErrorMessage, 18, 10)
		return;
	end catch
set nocount off
end
