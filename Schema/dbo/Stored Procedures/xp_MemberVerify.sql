
create procedure xp_MemberVerify
	@token uniqueidentifier,
	@guid uniqueidentifier
as begin
	declare @ssid int = (select SSID from vd_Session where UUID = @guid and Token = @token and [Type] = 3)
	if @ssid is null begin
		raiserror('Error', 18, 10)
		return;
	end else begin
		if exists(select 1 from vd_Session where SSID = @ssid and Expired >= getdate()) begin
			update Member
				set Verify = 1
				where Solt = @guid
		end else begin
			raiserror('Verify Key is Expired', 18, 10)
			return;
		end
	end
end