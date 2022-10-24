


CREATE   procedure [dbo].[xp_loginWithToken]
	@token uniqueidentifier,
	@mid int output
as
begin
set nocount on
	begin try
		declare @ssid int = (select SSID from vd_Session where Token = @token)
		if @ssid is null begin
			raiserror('Session not found', 18, 10)
			return;
		end else begin
			if exists(select 1 from vd_Session where SSID = @ssid and Expired < GETDATE()) begin
				raiserror('Session time out', 18, 10)
				return;
			end else begin
				set @mid = (select MID from vd_Session where SSID = @ssid)
				return;
			end
			return;
		end
	end try
	begin catch
		declare @ErrorMessage As VARCHAR(1000) = ERROR_MESSAGE()
		raiserror(@ErrorMessage, 18, 10)
		return;
	end catch
set nocount off
end
