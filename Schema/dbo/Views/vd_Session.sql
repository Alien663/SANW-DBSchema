


CREATE view [dbo].[vd_Session]
as
select
	M.MID,
	M.Account,
	M.Solt as UUID,
	M.EMail,
	M.NickName,
	S.SSID,
	S.Token,
	RefreshToken,
	DATEADD(ss, S.Expired, S.Since) as Expired,
	[Type]
from SystemSession S
	inner join Member M on S.MID = M.MID
where Expired is not null