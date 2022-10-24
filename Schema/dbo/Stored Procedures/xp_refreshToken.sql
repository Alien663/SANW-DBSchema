




CREATE   procedure [dbo].[xp_refreshToken]
	@token uniqueidentifier,
	@refresh_token uniqueidentifier,
	@new_token uniqueidentifier output,
	@new_refresh_token uniqueidentifier output,
	@mid int output
as
begin
	set nocount on
	begin try
		declare @ssid int = (select SSID from vd_Session where Token = @token and RefreshToken = @refresh_token)
		if @ssid is null begin
			raiserror('Session is not found', 18, 10)
			return;
		end else begin
			if exists(select 1 from vd_Session where SSID = @ssid and Expired < getdate())begin
				begin transaction
					update SystemSession
						set Expired = null
						where Token = @token
					select @new_refresh_token = NEWID(), @new_token = NEWID()
					set @mid = (select top 1 MID from SystemSession where SSID = @ssid)
					insert into SystemSession(Token, RefreshToken, MID, Expired, [Type])
						select @new_token, @new_refresh_token, MID, 600, 1
						from SystemSession
						where SSID = @ssid
				commit transaction
				return;
			end else begin
				raiserror('Session have not been expired.', 18, 10)
				return
			end
		end
	end try
	begin catch
		if @@TRANCOUNT >= 1
			rollback transaction
		DECLARE @ErrorMessage As VARCHAR(1000) = ERROR_MESSAGE()
		raiserror(@ErrorMessage, 18, 10)
		return;
	end catch
	set nocount off
end
