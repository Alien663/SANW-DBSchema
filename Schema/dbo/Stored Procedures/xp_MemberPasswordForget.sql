create procedure xp_MemberPasswordForget
	@account varchar(100),
	@email varchar(127)
as begin
	declare @mid int = (select MID from Member where Account = @account and EMail = @email)
	if @mid is null begin
		raiserror('Account or EMail is not correct', 18, 10)
		return;
	end else begin
		declare @token uniqueidentifier = newid()
		insert into SystemSession(Token, Expired, MID, [Type])
			values(@token, 600, @mid, 2)
	end
end