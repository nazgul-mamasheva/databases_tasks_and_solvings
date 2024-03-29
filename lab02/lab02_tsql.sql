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

CREATE TABLE [dbo].[Session](
	[ID_Session] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Start_date] [date] NOT NULL UNIQUE NONCLUSTERED,
	[Expiration_date] [date] NOT NULL UNIQUE NONCLUSTERED,
	CONSTRAINT [CHK_Date] CHECK  (([Start_date]<=[Expiration_date]))
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Subject](
	[ID_Subject] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Subject_name] [nvarchar](20) NOT NULL UNIQUE NONCLUSTERED,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Exam](
	[ID_Exam] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Subject] [int] NOT NULL REFERENCES [dbo].[Subject]([ID_Subject]), 
	[Date] [datetime] NOT NULL,
	[ID_Session] [int] NOT NULL REFERENCES [dbo].[Session]([ID_Session]),
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Country](
	[ID_Country] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Country_name] [nvarchar](30) NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[City](
	[ID_City] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Country] [int] NOT NULL REFERENCES [dbo].[Country]([ID_Country]),
	[City_name] [nvarchar](30) NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Examination_center](
	[ID_Examination_center] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_City] [int] NOT NULL REFERENCES [dbo].[City]([ID_City]),
	[Address] [nvarchar](30) NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Contact_information](
	[ID_Contact] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Phone] [int] NOT NULL,
	[Email] [nvarchar](30) NULL,
	[Address] [nvarchar](30) NOT NULL,
	[Extra_contact_info] [nvarchar](50) NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Applicant](
	[ID_Applicant] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](20) NOT NULL,
	[Surname] [nvarchar](20) NOT NULL,
	[Date_of_birth] [date] NOT NULL,
	[ID_Contact] [int] NOT NULL REFERENCES [dbo].[Contact_information]([ID_Contact]),
	[Education] [nvarchar](100) NULL,
	[Professional_experience] [nvarchar](100) NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Participant](
	[ID_Participant] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Exam] [int] NOT NULL UNIQUE NONCLUSTERED REFERENCES [dbo].[Exam]([ID_Exam]),
	[ID_Examination_center] [int] NOT NULL REFERENCES [dbo].[Examination_center]([ID_Examination_center]),
	[Result] [bit] NOT NULL,
	[ID_Applicant] [int] NOT NULL REFERENCES [dbo].[Applicant]([ID_Applicant]),
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Work_of_participant](
	[ID_Work] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Participant] [int] NOT NULL REFERENCES [dbo].[Participant]([ID_Participant]),
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Question](
	[ID_Question] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Question] [nvarchar](100) NOT NULL,
	[Max_point] [int] NOT NULL,
	[ID_Exam] [int] NOT NULL REFERENCES [dbo].[Exam]([ID_Exam]),
	CONSTRAINT [UQ_Question_max_point_Question] UNIQUE NONCLUSTERED ([ID_Question] ASC,[Max_point] ASC)
) ON [PRIMARY]	
GO

CREATE TABLE [dbo].[Checker](
	[ID_Checker] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Name_Surname] [nvarchar] NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Answer_Evaluation](
    [ID_Answer] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ID_Question] [int] NOT NULL,
	[Max_point] [int] NOT NULL,
	[ID_Checker_1] [int] NOT NULL REFERENCES [dbo].[Checker]([ID_Checker]),
	[Result_of_Check_1] [int] NOT NULL,
	[ID_Checker_2] [int] NOT NULL REFERENCES [dbo].[Checker]([ID_Checker]),
	[Result_of_Check_2] [int] NOT NULL,
	[ID_Checker_3] [int] NOT NULL REFERENCES [dbo].[Checker]([ID_Checker]),
	[Result_of_Check_3] [int] NOT NULL,
	[ID_Work] [int] NOT NULL REFERENCES [dbo].[Work_of_participant]([ID_Work]),
	CONSTRAINT [UQ_Question_max_point] UNIQUE NONCLUSTERED ([ID_Question] ASC,[Max_point] ASC),
	CONSTRAINT [UQ_Question_Answer_max_point] FOREIGN KEY ([ID_Question],[Max_point]) REFERENCES [dbo].[Question]([ID_Question],[Max_point]),
) ON [PRIMARY]
GO
