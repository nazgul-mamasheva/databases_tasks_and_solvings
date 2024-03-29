USE [master]
GO

CREATE DATABASE [CIPA] 
ON (
NAME = N'CIPA_data', 
FILENAME = N'D:\MSSQL\MSSQL10_50.SQL2008\MSSQL\DATA\CIPA.mdf' , 
SIZE = 3072KB , 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 1024KB )

LOG ON ( 
NAME = N'CIPA_log', 
FILENAME = N'D:\MSSQL\MSSQL10_50.SQL2008\MSSQL\DATA\CIPA_log.ldf' , 
SIZE = 1024KB ,
MAXSIZE = 2048GB , 
FILEGROWTH = 10%)
GO

USE [CIPA]
GO

CREATE TABLE [dbo].[Applicant](
	[ID_Applicant] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](20) NOT NULL,
	[Surname] [nvarchar](20) NOT NULL,
	[Contact_information] [nvarchar](30) NOT NULL,
	[Date_of_birth] [date] NOT NULL,
	[Education] [nvarchar](100) NULL,
	[Professional_experience] [nvarchar](100) NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Participant](
	[ID_Participant] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Applicant] [int] NOT NULL REFERENCES [dbo].[Applicant]([ID_Applicant]),
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Country](
	[ID_Country] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Country_name] [nvarchar](30) NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[City](
	[ID_City] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[City_name] [nvarchar](30) NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Examination_center](
	[ID_Examination_center] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Examination_center_name] [nvarchar](30) NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Place_of_exam](
	[ID_Place_of_exam] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Country] [int] NOT NULL REFERENCES [dbo].[Country]([ID_Country]),
	[ID_City] [int] NOT NULL REFERENCES [dbo].[City]([ID_City]),
	[ID_Examination_center] [int] NOT NULL REFERENCES [dbo].[Examination_center]([ID_Examination_center]),
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[_Session_](
	[ID_Session] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Start_date] [date] NOT NULL UNIQUE NONCLUSTERED,
	[Expiration_date] [date] NOT NULL UNIQUE NONCLUSTERED,
	CONSTRAINT [CHK_Date] CHECK  (([Start_date]<=[Expiration_date]))
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Subject](
	[ID_Subject] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Subject_name] [nvarchar](20) NOT NULL, UNIQUE NONCLUSTERED,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Exam](
	[ID_Exam] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Subject] [int] NOT NULL REFERENCES [dbo].[Subject]([ID_Subject]), 
	[ID_Place_of_exam] [int] NOT NULL REFERENCES [dbo].[Place_of_exam]([ID_Place_of_exam]),
	[_Date_] [datetime] NOT NULL,
	[ID_Session] [int] NOT NULL REFERENCES [dbo].[_Session_]([ID_Session]),
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Work_of_participant](
	[ID_Work] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Participant] [int] NOT NULL REFERENCES [dbo].[Participant]([ID_Participant]),
	[ID_Exam] [int] NOT NULL REFERENCES [dbo].[Exam]([ID_Exam]),
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Checker](
	[ID_Checker] [int] NOT NULL,
	[Name_Surname] [nvarchar] NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Result_of_work](
	[ID_Result_of_work] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Work] [int] NOT NULL UNIQUE NONCLUSTERED REFERENCES [dbo].[Work_of_participant]([ID_Work]),
	[ID_Checker_1] [int] NOT NULL REFERENCES [dbo].[Checker]([ID_Cheker]),
	[Result_of_Check_1] [int] NOT NULL,
	[ID_Checker_2] [int] NOT NULL REFERENCES [dbo].[Checker]([ID_Cheker]),
	[Result_of_Check_2] [int] NOT NULL,
	[ID_Checker_3] [int] NOT NULL REFERENCES [dbo].[Checker]([ID_Cheker]),
	[Result_of_Check_3] [int] NOT NULL,
	[Final_Result] [bit] NOT NULL,
) ON [PRIMARY]
GO



