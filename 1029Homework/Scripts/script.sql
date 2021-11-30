USE [Survey1029 ]
GO
/****** Object:  Table [dbo].[Answers]    Script Date: 2021/11/30 上午 10:46:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answers](
	[AnsID] [int] NOT NULL,
	[A_UserName] [nvarchar](50) NOT NULL,
	[A_UserPhone] [varchar](10) NOT NULL,
	[A_UserEmail] [nvarchar](50) NOT NULL,
	[A_UserAge] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[Answer] [nvarchar](100) NOT NULL,
	[PostID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Answers] PRIMARY KEY CLUSTERED 
(
	[AnsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MixQus]    Script Date: 2021/11/30 上午 10:46:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MixQus](
	[QuID] [int] NOT NULL,
	[Caption] [nvarchar](50) NOT NULL,
	[Ans] [nvarchar](50) NULL,
	[Type] [int] NOT NULL,
	[Nullable] [bit] NOT NULL,
	[Available] [bit] NOT NULL,
 CONSTRAINT [PK_MixQes] PRIMARY KEY CLUSTERED 
(
	[QuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 2021/11/30 上午 10:46:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[QuID] [int] NOT NULL,
	[Caption] [nvarchar](50) NOT NULL,
	[Type] [int] NOT NULL,
	[Nullable] [bit] NOT NULL,
	[Ans] [nvarchar](50) NOT NULL,
	[Available] [bit] NOT NULL,
	[PostID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[QuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Surevy]    Script Date: 2021/11/30 上午 10:46:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Surevy](
	[Title] [nvarchar](20) NOT NULL,
	[ActType] [bit] NOT NULL,
	[Starttime] [date] NOT NULL,
	[Endtime] [date] NOT NULL,
	[Body] [nvarchar](100) NULL,
	[PostID] [uniqueidentifier] NOT NULL,
	[Available] [bit] NOT NULL,
 CONSTRAINT [PK_Surevy] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 2021/11/30 上午 10:46:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[Name] [nvarchar](50) NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[Account] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Surevy]  WITH CHECK ADD  CONSTRAINT [FK_Surevy_Surevy] FOREIGN KEY([PostID])
REFERENCES [dbo].[Surevy] ([PostID])
GO
ALTER TABLE [dbo].[Surevy] CHECK CONSTRAINT [FK_Surevy_Surevy]
GO
