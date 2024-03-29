﻿

CREATE   procedure [dbo].[xp_MemberRenewPassword]
	@mid int,
	@oldpassword varchar(100),
	@newpassword varchar(100)
as begin
	if exists(select 1 from Member where MID = @mid and [Password] = (select HASHBYTES('SHA2_256', @oldpassword + REPLACE(CONVERT(varchar(36), Solt), '-', '')))) begin
		declare @newpwd binary(32) = (select HASHBYTES('SHA2_256', @newpassword + REPLACE(CONVERT(varchar(36), Solt), '-', '')) from Member where MID = @mid)
		if exists(select 1 from Member where MID = @mid and [Password] = @newpwd) begin
			raiserror('New Password is not allow to be the same as the old one', 18, 10)
			return;
		end else begin
			update Member
				set [Password] = @newpwd
				where MID = @mid
		end 
	end else begin
		raiserror('Permission denied', 18, 10)
		return;
	end
end