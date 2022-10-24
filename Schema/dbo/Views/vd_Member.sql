create   view vd_Member
as
select
	MID,
	Solt as UUID,
	Account,
	EMail,
	NickName,
	Since, 
	ModifyDatetime
from Member