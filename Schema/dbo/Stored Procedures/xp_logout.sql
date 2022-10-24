

CREATE procedure [dbo].[xp_logout]
	@mid int,
	@token uniqueidentifier,
	@refreshtoken uniqueidentifier
as begin
	begin try
		declare @ssid int = (select SSID from vd_Session where MID = @mid and Token = @token and RefreshToken = @refreshtoken)
		if @ssid is null begin
			raiserror('User had been logout', 18, 10)
			return
		end else begin
			update SystemSession
				set Expired = null
				where SSID = @ssid
		end
	end try
	begin catch
		DECLARE @ErrorMessage As VARCHAR(1000) =ERROR_MESSAGE()
		raiserror(@ErrorMessage, 18, 10)
		return;
	end catch
end