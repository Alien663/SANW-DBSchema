CREATE TABLE [dbo].[Member] (
    [MID]            INT              IDENTITY (1, 1) NOT NULL,
    [Account]        VARCHAR (100)    NOT NULL,
    [Password]       BINARY (32)      NOT NULL,
    [EMail]          VARCHAR (127)    NOT NULL,
    [NickName]       NVARCHAR (60)    NULL,
    [Solt]           UNIQUEIDENTIFIER NOT NULL,
    [Since]          DATETIME         DEFAULT (getdate()) NOT NULL,
    [ModifyDatetime] DATETIME         DEFAULT (getdate()) NOT NULL,
    [Verify]         BIT              DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED ([MID] ASC),
    UNIQUE NONCLUSTERED ([Account] ASC),
    UNIQUE NONCLUSTERED ([EMail] ASC),
    UNIQUE NONCLUSTERED ([Solt] ASC)
);



