USE [master]
GO
/****** Object:  Database [mamasheva_n]    Script Date: 02/04/2015 21:11:59 ******/
CREATE DATABASE [mamasheva_n] ON  PRIMARY 
( NAME = N'mamasheva_n', FILENAME = N'D:\MSSQL\MSSQL10_50.SQL2008\MSSQL\DATA\mamasheva_n.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'mamasheva_n_log', FILENAME = N'D:\MSSQL\MSSQL10_50.SQL2008\MSSQL\DATA\mamasheva_n_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [mamasheva_n] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [mamasheva_n].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [mamasheva_n] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [mamasheva_n] SET ANSI_NULLS OFF
GO
ALTER DATABASE [mamasheva_n] SET ANSI_PADDING OFF
GO
ALTER DATABASE [mamasheva_n] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [mamasheva_n] SET ARITHABORT OFF
GO
ALTER DATABASE [mamasheva_n] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [mamasheva_n] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [mamasheva_n] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [mamasheva_n] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [mamasheva_n] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [mamasheva_n] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [mamasheva_n] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [mamasheva_n] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [mamasheva_n] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [mamasheva_n] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [mamasheva_n] SET  DISABLE_BROKER
GO
ALTER DATABASE [mamasheva_n] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [mamasheva_n] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [mamasheva_n] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [mamasheva_n] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [mamasheva_n] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [mamasheva_n] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [mamasheva_n] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [mamasheva_n] SET  READ_WRITE
GO
ALTER DATABASE [mamasheva_n] SET RECOVERY FULL
GO
ALTER DATABASE [mamasheva_n] SET  MULTI_USER
GO
ALTER DATABASE [mamasheva_n] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [mamasheva_n] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'mamasheva_n', N'ON'
GO
USE [mamasheva_n]
GO
/****** Object:  Table [dbo].[Справочник Решений комиссии]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Справочник Решений комиссии](
	[ID Решений комиссии] [int] NOT NULL,
	[Решение комиссии] [nvarchar](50) NOT NULL,
	[Описание] [nvarchar](50) NULL,
 CONSTRAINT [PK_Справочник Решений комиссии] PRIMARY KEY CLUSTERED 
(
	[ID Решений комиссии] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Сотрудник]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Сотрудник](
	[ID Сотрудника] [int] NOT NULL,
	[ФИО] [char](30) NOT NULL,
	[Дата рождения] [date] NOT NULL,
	[Описание] [nvarchar](50) NULL,
 CONSTRAINT [PK_Сотрудник] PRIMARY KEY CLUSTERED 
(
	[ID Сотрудника] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Должность в комиссии]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Должность в комиссии](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Наименование] [char](20) NOT NULL,
	[Описание] [nvarchar](50) NULL,
 CONSTRAINT [PK_Должность в комиссии] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Должность в комиссии_Наименование] UNIQUE NONCLUSTERED 
(
	[Наименование] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Документ]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Документ](
	[ID Документ] [int] NOT NULL,
	[Наименование] [char](30) NOT NULL,
	[Дата и время Регистрации] [datetime] NOT NULL,
	[Документ] [nchar](20) NULL,
	[РодительскийID] [int] NOT NULL,
	[ID Типа Документа] [int] NOT NULL,
	[Зарегистрировал Сотрудник] [int] NOT NULL,
	[Имя файла] [char](10) NULL,
 CONSTRAINT [PK_Документ] PRIMARY KEY CLUSTERED 
(
	[ID Документ] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[План_Заседания_комиссии]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[План_Заседания_комиссии](
	[ID Заседания комиссии] [int] NOT NULL,
	[ID_Заседания] [int] NOT NULL,
	[ID_Лицензии] [int] NOT NULL,
	[ID Решений комиссии] [int] NOT NULL,
	[Описание Решения комиссии] [nvarchar](50) NULL,
	[Выписка Из протокола] [nvarchar](50) NULL,
	[Время_начала] [datetime] NOT NULL,
	[Время_конца] [datetime] NOT NULL,
 CONSTRAINT [uq_План_Заседания_комиссии] UNIQUE NONCLUSTERED 
(
	[ID_Заседания] ASC,
	[ID_Лицензии] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Лицензия]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Лицензия](
	[ID Лицензии] [int] NOT NULL,
	[Номер Лицензии] [int] NOT NULL,
	[ID Организации] [int] NULL,
	[Дата и время регистрации] [datetime] NOT NULL,
	[ID Типа Лицензии] [int] NOT NULL,
	[Номер заявки] [int] NOT NULL,
	[Дата_выдачи] [date] NOT NULL,
	[Дата_окончания] [date] NOT NULL,
 CONSTRAINT [UQ_Лицензия_Номер_заявки] UNIQUE NONCLUSTERED 
(
	[Номер заявки] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Лицензия_Номер_Лицензии] UNIQUE NONCLUSTERED 
(
	[Номер Лицензии] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Комиссия]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Комиссия](
	[ID Комиссии] [int] NOT NULL,
	[Дата_начало_работы] [date] NOT NULL,
	[Дата_окончания_работы] [date] NOT NULL,
	[ID Документа] [int] NULL,
 CONSTRAINT [PK_Комиссия] PRIMARY KEY CLUSTERED 
(
	[ID Комиссии] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Решение_Члена_комиссии]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Решение_Члена_комиссии](
	[Id] [int] NOT NULL,
	[ID_Заседания] [int] NOT NULL,
	[ID_Лицензии] [int] NOT NULL,
	[ID член комиссии] [int] NOT NULL,
	[Специальное мнение] [nvarchar](50) NULL,
	[ID Решений комиссии] [int] NOT NULL,
 CONSTRAINT [PK_Решение Члена комиссии] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [uq_Решение_Члена_комиссии] UNIQUE NONCLUSTERED 
(
	[ID_Заседания] ASC,
	[ID_Лицензии] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Член_комиссии]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Член_комиссии](
	[ID член комиссии] [int] NULL,
	[ID_Комиссии] [int] NULL,
	[ID_Сотрудника] [int] NULL,
	[ID Должность] [int] NULL,
 CONSTRAINT [uq_Член_комиссии] UNIQUE NONCLUSTERED 
(
	[ID_Комиссии] ASC,
	[ID_Сотрудника] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Заседание Комиссии]    Script Date: 02/04/2015 21:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Заседание Комиссии](
	[ID Заседания] [int] NOT NULL,
	[Дата заседания] [datetime] NULL,
	[ID Комиссии] [int] NOT NULL,
	[Протокол] [nvarchar](20) NULL,
 CONSTRAINT [PK_Заседание Комиссии] PRIMARY KEY CLUSTERED 
(
	[ID Заседания] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Check [CK_План Заседания комиссии_Время]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[План_Заседания_комиссии]  WITH CHECK ADD  CONSTRAINT [CK_План Заседания комиссии_Время] CHECK  (([Время_начала]<=[Время_конца]))
GO
ALTER TABLE [dbo].[План_Заседания_комиссии] CHECK CONSTRAINT [CK_План Заседания комиссии_Время]
GO
/****** Object:  Check [CK_Лицензия_Дата]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Лицензия]  WITH CHECK ADD  CONSTRAINT [CK_Лицензия_Дата] CHECK  (([Дата_выдачи]<=[Дата_окончания]))
GO
ALTER TABLE [dbo].[Лицензия] CHECK CONSTRAINT [CK_Лицензия_Дата]
GO
/****** Object:  Check [CK_Комиссия_Дата]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Комиссия]  WITH CHECK ADD  CONSTRAINT [CK_Комиссия_Дата] CHECK  (([Дата_начало_работы]<=[Дата_окончания_работы]))
GO
ALTER TABLE [dbo].[Комиссия] CHECK CONSTRAINT [CK_Комиссия_Дата]
GO
/****** Object:  ForeignKey [FK_Документ_Документ]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Документ]  WITH CHECK ADD  CONSTRAINT [FK_Документ_Документ] FOREIGN KEY([РодительскийID])
REFERENCES [dbo].[Документ] ([ID Документ])
GO
ALTER TABLE [dbo].[Документ] CHECK CONSTRAINT [FK_Документ_Документ]
GO
/****** Object:  ForeignKey [FK_Комиссия_Документ]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Комиссия]  WITH CHECK ADD  CONSTRAINT [FK_Комиссия_Документ] FOREIGN KEY([ID Документа])
REFERENCES [dbo].[Документ] ([ID Документ])
GO
ALTER TABLE [dbo].[Комиссия] CHECK CONSTRAINT [FK_Комиссия_Документ]
GO
/****** Object:  ForeignKey [FK_Решение Члена комиссии_Решение Члена комиссии]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Решение_Члена_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Решение Члена комиссии_Решение Члена комиссии] FOREIGN KEY([Id])
REFERENCES [dbo].[Решение_Члена_комиссии] ([Id])
GO
ALTER TABLE [dbo].[Решение_Члена_комиссии] CHECK CONSTRAINT [FK_Решение Члена комиссии_Решение Члена комиссии]
GO
/****** Object:  ForeignKey [FK_Решение Члена комиссии_Решение Члена комиссии1]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Решение_Члена_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Решение Члена комиссии_Решение Члена комиссии1] FOREIGN KEY([Id])
REFERENCES [dbo].[Решение_Члена_комиссии] ([Id])
GO
ALTER TABLE [dbo].[Решение_Члена_комиссии] CHECK CONSTRAINT [FK_Решение Члена комиссии_Решение Члена комиссии1]
GO
/****** Object:  ForeignKey [FK_Решение Члена комиссии_Справочник Члена комиссии]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Решение_Члена_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Решение Члена комиссии_Справочник Члена комиссии] FOREIGN KEY([ID Решений комиссии])
REFERENCES [dbo].[Справочник Решений комиссии] ([ID Решений комиссии])
GO
ALTER TABLE [dbo].[Решение_Члена_комиссии] CHECK CONSTRAINT [FK_Решение Члена комиссии_Справочник Члена комиссии]
GO
/****** Object:  ForeignKey [FK_Член комиссии_Должность в комиссии]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Член_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Член комиссии_Должность в комиссии] FOREIGN KEY([ID Должность])
REFERENCES [dbo].[Должность в комиссии] ([Id])
GO
ALTER TABLE [dbo].[Член_комиссии] CHECK CONSTRAINT [FK_Член комиссии_Должность в комиссии]
GO
/****** Object:  ForeignKey [FK_Член комиссии_Комиссия]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Член_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Член комиссии_Комиссия] FOREIGN KEY([ID_Комиссии])
REFERENCES [dbo].[Комиссия] ([ID Комиссии])
GO
ALTER TABLE [dbo].[Член_комиссии] CHECK CONSTRAINT [FK_Член комиссии_Комиссия]
GO
/****** Object:  ForeignKey [FK_Член комиссии_Сотрудник]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Член_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Член комиссии_Сотрудник] FOREIGN KEY([ID_Сотрудника])
REFERENCES [dbo].[Сотрудник] ([ID Сотрудника])
GO
ALTER TABLE [dbo].[Член_комиссии] CHECK CONSTRAINT [FK_Член комиссии_Сотрудник]
GO
/****** Object:  ForeignKey [FK_Заседание Комиссии_Комиссия]    Script Date: 02/04/2015 21:12:00 ******/
ALTER TABLE [dbo].[Заседание Комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Заседание Комиссии_Комиссия] FOREIGN KEY([ID Комиссии])
REFERENCES [dbo].[Комиссия] ([ID Комиссии])
GO
ALTER TABLE [dbo].[Заседание Комиссии] CHECK CONSTRAINT [FK_Заседание Комиссии_Комиссия]
GO
