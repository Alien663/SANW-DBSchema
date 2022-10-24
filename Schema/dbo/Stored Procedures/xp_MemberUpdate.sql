
CREATE   procedure [dbo].[xp_MemberUpdate]
	@mid int,
	@uuid uniqueidentifier,
	@acc varchar(100),
	@nickname varchar(60),
	@email varchar(127)
as begin
	if not exists(select 1 from Member where MID = @mid and Solt = @uuid and Account = @acc) begin
		raiserror('User is not exists', 18, 10)
		return;
	end
	if exists(select 1 from Member where MID = @mid) begin
		update Member
			set NickName = @nickname,
				EMail = @email,
				ModifyDatetime = GETDATE()
			where MID = @mid
	end else begin
		raiserror('User is not exists', 18, 10)
		return;
	end
end