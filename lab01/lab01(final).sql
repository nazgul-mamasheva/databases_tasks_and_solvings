USE [master]
GO

CREATE DATABASE [mamasheva_n] 
ON (
NAME = N'mamasheva_n_data', 
FILENAME = N'D:\MSSQL\MSSQL10_50.SQL2008\MSSQL\DATA\mamasheva_n.mdf' , 
SIZE = 3072KB , 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 1024KB )

LOG ON ( 
NAME = N'mamasheva_n_log', 
FILENAME = N'D:\MSSQL\MSSQL10_50.SQL2008\MSSQL\DATA\mamasheva_n_log.ldf' , 
SIZE = 1024KB ,
MAXSIZE = 2048GB , 
FILEGROWTH = 10%)
GO

USE [mamasheva_n]
GO

CREATE TABLE [dbo].[Справочник_Решений_комиссии](
	[ID_Решений_комиссии] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Решение_комиссии] [nvarchar](50) NOT NULL,
	[Описание] [nvarchar](50) NULL,
	[РодительскийID] [int] NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Сотрудник](
	[ID_Сотрудника] [int] NOT NULL IDENTITY(1,1)PRIMARY KEY,
	[ФИО] [char](30) NOT NULL,
	[Дата_рождения] [date] NOT NULL,
	[Описание] [nvarchar](50) NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Лицензия](
	[ID_Лицензии] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Номер_Лицензии] [int] NOT NULL UNIQUE NONCLUSTERED,
	[ID_Организации] [int] NULL,
	[Дата_и_время_регистрации] [datetime] NOT NULL,
	[ID_Типа_Лицензии] [int] NOT NULL,
	[Номер_заявки] [int] NOT NULL UNIQUE NONCLUSTERED,
	[Дата_выдачи] [date] NOT NULL,
	[Дата_окончания] [date] NOT NULL,
	CONSTRAINT [CK_Лицензия_Дата] CHECK  (([Дата_выдачи]<=[Дата_окончания]))
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Должность_в_комиссии](
	[Id] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Наименование] [char](20) NOT NULL,
	[Описание] [nvarchar](50) NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Документ](
	[ID_Документ] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Наименование] [char](30) NOT NULL,
	[Дата_и_время_Регистрации] [datetime] NOT NULL,
	[Документ] [nchar](20) NULL,
	[РодительскийID] [int] NULL,
	[Зарегистрировал_Сотрудник] [int] NOT NULL,
	[Имя_файла] [char](10) NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Комиссия](
	[ID Комиссии] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Дата_начало_работы] [date] NOT NULL,
	[Дата_окончания_работы] [date] NOT NULL,
	[ID Документа] [int] NOT NULL,
	CONSTRAINT [CK_Комиссия_Дата] CHECK  (([Дата_начало_работы]<=[Дата_окончания_работы]))
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Член_комиссии](
	[ID_член_комиссии] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Комиссии] [int] NOT NULL,
	[ID_Сотрудника] [int] NOT NULL,
	[ID_Должность] [int] NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Заседание_Комиссии](
	[ID_Заседания] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Дата_заседания] [datetime] NOT NULL,
	[ID_Комиссии] [int] NOT NULL,
	[Протокол] [int] NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Решение_Члена_комиссии](
	[Id] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Заседания] [int] NOT NULL,
	[ID_Лицензии] [int] NOT NULL,
	[ID_член_комиссии] [int] NOT NULL,
	[Специальное_мнение] [nvarchar](50) NULL,
	[ID_Решений_комиссии] [int] NOT NULL,
CONSTRAINT [uq_Решение_Члена_комиссии] UNIQUE NONCLUSTERED ([ID_Заседания] ASC,[ID_Лицензии] ASC)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[План_Заседания_комиссии](
	[ID Заседания комиссии] [int] NOT NULL IDENTITY(1,1),
	[ID_Заседания] [int] NOT NULL,
	[ID_Лицензии] [int] NOT NULL,
	[ID Решений комиссии] [int] NULL,
	[Описание Решения комиссии] [nvarchar](50) NULL,
	[Выписка Из протокола] [int] NULL,
	[Время_начала] [datetime] NOT NULL,
	[Время_конца] [datetime] NOT NULL,
 CONSTRAINT [uq_План_Заседания_Комиссии] UNIQUE NONCLUSTERED ([ID_Заседания] ASC,[ID_Лицензии] ASC),
 CONSTRAINT [CK_План Заседания комиссии_Время] CHECK  (([Время_начала]<=[Время_конца]))
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[Справочник Решений комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Справочник Решений комиссии_Справочник Решений комиссии] FOREIGN KEY([РодительскийID])
REFERENCES [dbo].[Справочник Решений комиссии] ([ID Решений комиссии])
GO
ALTER TABLE [dbo].[Справочник Решений комиссии] CHECK CONSTRAINT [FK_Справочник Решений комиссии_Справочник Решений комиссии]
GO
/****** Object:  ForeignKey [FK_Документ_Документ]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Документ]  WITH CHECK ADD  CONSTRAINT [FK_Документ_Документ] FOREIGN KEY([РодительскийID])
REFERENCES [dbo].[Документ] ([ID Документ])
GO
ALTER TABLE [dbo].[Документ] CHECK CONSTRAINT [FK_Документ_Документ]
GO
/****** Object:  ForeignKey [FK_Документ_Сотрудник]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Документ]  WITH CHECK ADD  CONSTRAINT [FK_Документ_Сотрудник] FOREIGN KEY([Зарегистрировал Сотрудник])
REFERENCES [dbo].[Сотрудник] ([ID Сотрудника])
GO
ALTER TABLE [dbo].[Документ] CHECK CONSTRAINT [FK_Документ_Сотрудник]
GO
/****** Object:  ForeignKey [FK_Комиссия_Документы]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Комиссия]  WITH CHECK ADD  CONSTRAINT [FK_Комиссия_Документы] FOREIGN KEY([ID Документа])
REFERENCES [dbo].[Документ] ([ID Документ])
GO
ALTER TABLE [dbo].[Комиссия] CHECK CONSTRAINT [FK_Комиссия_Документы]
GO
/****** Object:  ForeignKey [FK_Член комиссии_Должность в комиссии]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Член_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Член комиссии_Должность в комиссии] FOREIGN KEY([ID Должность])
REFERENCES [dbo].[Должность в комиссии] ([Id])
GO
ALTER TABLE [dbo].[Член_комиссии] CHECK CONSTRAINT [FK_Член комиссии_Должность в комиссии]
GO
/****** Object:  ForeignKey [FK_Член комиссии_Комиссия]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Член_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Член комиссии_Комиссия] FOREIGN KEY([ID_Комиссии])
REFERENCES [dbo].[Комиссия] ([ID Комиссии])
GO
ALTER TABLE [dbo].[Член_комиссии] CHECK CONSTRAINT [FK_Член комиссии_Комиссия]
GO
/****** Object:  ForeignKey [FK_Член комиссии_Сотрудник]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Член_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Член комиссии_Сотрудник] FOREIGN KEY([ID_Сотрудника])
REFERENCES [dbo].[Сотрудник] ([ID Сотрудника])
GO
ALTER TABLE [dbo].[Член_комиссии] CHECK CONSTRAINT [FK_Член комиссии_Сотрудник]
GO
/****** Object:  ForeignKey [FK_Заседание Комиссии_Документы]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Заседание Комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Заседание Комиссии_Документы] FOREIGN KEY([Протокол])
REFERENCES [dbo].[Документ] ([ID Документ])
GO
ALTER TABLE [dbo].[Заседание Комиссии] CHECK CONSTRAINT [FK_Заседание Комиссии_Документы]
GO
/****** Object:  ForeignKey [FK_Заседание Комиссии_Комиссия]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Заседание Комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Заседание Комиссии_Комиссия] FOREIGN KEY([ID Комиссии])
REFERENCES [dbo].[Комиссия] ([ID Комиссии])
GO
ALTER TABLE [dbo].[Заседание Комиссии] CHECK CONSTRAINT [FK_Заседание Комиссии_Комиссия]
GO
/****** Object:  ForeignKey [FK_Решение Члена комиссии_Члена_комиссии]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Решение_Члена_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Решение Члена комиссии_Члена_комиссии] FOREIGN KEY([ID член комиссии])
REFERENCES [dbo].[Член_комиссии] ([ID член комиссии])
GO
ALTER TABLE [dbo].[Решение_Члена_комиссии] CHECK CONSTRAINT [FK_Решение Члена комиссии_Члена_комиссии]
GO
/****** Object:  ForeignKey [FK_Решение_Члена_комиссии_Решение_Лицензия]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Решение_Члена_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Решение_Члена_комиссии_Решение_Лицензия] FOREIGN KEY([ID_Лицензии])
REFERENCES [dbo].[Лицензия] ([ID Лицензии])
GO
ALTER TABLE [dbo].[Решение_Члена_комиссии] CHECK CONSTRAINT [FK_Решение_Члена_комиссии_Решение_Лицензия]
GO
/****** Object:  ForeignKey [FK_Решение_Члена_комиссии_Справочник Решений комиссии]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[Решение_Члена_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_Решение_Члена_комиссии_Справочник Решений комиссии] FOREIGN KEY([ID Решений комиссии])
REFERENCES [dbo].[Справочник Решений комиссии] ([ID Решений комиссии])
GO
ALTER TABLE [dbo].[Решение_Члена_комиссии] CHECK CONSTRAINT [FK_Решение_Члена_комиссии_Справочник Решений комиссии]
GO
/****** Object:  ForeignKey [FK_План_Заседания_комиссии_Документы]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[План_Заседания_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_План_Заседания_комиссии_Документы] FOREIGN KEY([Выписка Из протокола])
REFERENCES [dbo].[Документ] ([ID Документ])
GO
ALTER TABLE [dbo].[План_Заседания_комиссии] CHECK CONSTRAINT [FK_План_Заседания_комиссии_Документы]
GO
/****** Object:  ForeignKey [FK_План_Заседания_комиссии_Заседание Комиссии]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[План_Заседания_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_План_Заседания_комиссии_Заседание Комиссии] FOREIGN KEY([ID_Заседания])
REFERENCES [dbo].[Заседание Комиссии] ([ID Заседания])
GO
ALTER TABLE [dbo].[План_Заседания_комиссии] CHECK CONSTRAINT [FK_План_Заседания_комиссии_Заседание Комиссии]
GO
/****** Object:  ForeignKey [FK_План_Заседания_комиссии_Лицензия]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[План_Заседания_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_План_Заседания_комиссии_Лицензия] FOREIGN KEY([ID_Лицензии])
REFERENCES [dbo].[Лицензия] ([ID Лицензии])
GO
ALTER TABLE [dbo].[План_Заседания_комиссии] CHECK CONSTRAINT [FK_План_Заседания_комиссии_Лицензия]
GO
/****** Object:  ForeignKey [FK_План_Заседания_комиссии_Справочник_Решений_комиссии]    Script Date: 02/05/2015 17:46:47 ******/
ALTER TABLE [dbo].[План_Заседания_комиссии]  WITH CHECK ADD  CONSTRAINT [FK_План_Заседания_комиссии_Справочник_Решений_комиссии] FOREIGN KEY([ID Решений комиссии])
REFERENCES [dbo].[Справочник Решений комиссии] ([ID Решений комиссии])
GO
ALTER TABLE [dbo].[План_Заседания_комиссии] CHECK CONSTRAINT [FK_План_Заседания_комиссии_Справочник_Решений_комиссии]
GO
