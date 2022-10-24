CREATE TABLE [dbo].[Tag] (
    [TID]            INT            IDENTITY (1, 1) NOT NULL,
    [TagName]        NVARCHAR (64)  NULL,
    [TagDescription] NVARCHAR (127) NULL,
    CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED ([TID] ASC)
);

