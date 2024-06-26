USE [master]
GO
/****** Object:  Database [ExSys]    Script Date: 6/21/2024 7:35:57 PM ******/
CREATE DATABASE [ExSys]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ExSys', FILENAME = N'/var/opt/mssql/data/ExSys.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ExSys_log', FILENAME = N'/var/opt/mssql/data/ExSys_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ExSys] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ExSys].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ExSys] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ExSys] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ExSys] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ExSys] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ExSys] SET ARITHABORT OFF 
GO
ALTER DATABASE [ExSys] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ExSys] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ExSys] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ExSys] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ExSys] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ExSys] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ExSys] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ExSys] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ExSys] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ExSys] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ExSys] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ExSys] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ExSys] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ExSys] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ExSys] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ExSys] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ExSys] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ExSys] SET RECOVERY FULL 
GO
ALTER DATABASE [ExSys] SET  MULTI_USER 
GO
ALTER DATABASE [ExSys] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ExSys] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ExSys] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ExSys] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ExSys] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ExSys] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ExSys', N'ON'
GO
ALTER DATABASE [ExSys] SET QUERY_STORE = ON
GO
ALTER DATABASE [ExSys] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ExSys]
GO
/****** Object:  User [TrainingManager1]    Script Date: 6/21/2024 7:36:00 PM ******/
CREATE USER [TrainingManager1] FOR LOGIN [TrainingManager1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Student1]    Script Date: 6/21/2024 7:36:00 PM ******/
CREATE USER [Student1] FOR LOGIN [Student1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Instructor1]    Script Date: 6/21/2024 7:36:00 PM ******/
CREATE USER [Instructor1] FOR LOGIN [Instructor1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Admin1]    Script Date: 6/21/2024 7:36:00 PM ******/
CREATE USER [Admin1] FOR LOGIN [Admin1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[AuthenticateUser]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Authenricate user
CREATE FUNCTION [dbo].[AuthenticateUser]
(
    @Email VARCHAR(255),
    @Password VARCHAR(255)
)
RETURNS BIT
AS
BEGIN
    DECLARE @UserId INT;
    DECLARE @IsAuthenticated BIT = 0;
    DECLARE @HashedPassword VARCHAR(256);

    SELECT @UserId = UserId
    FROM [User]
    WHERE Email = @Email;

    IF @UserId IS NOT NULL
    BEGIN
        SET @HashedPassword = CONVERT(VARCHAR(256), HASHBYTES('SHA2_256', @Password), 2);

        DECLARE @StoredPassword VARCHAR(256);
        SELECT @StoredPassword = Password
        FROM UserAuth
        WHERE UserId = @UserId;

        IF @StoredPassword = @HashedPassword
        BEGIN
            SET @IsAuthenticated = 1;
        END
    END

    RETURN @IsAuthenticated;
END;
GO
/****** Object:  Table [dbo].[Track]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[TrackId] [int] IDENTITY(1,1) NOT NULL,
	[TrackName] [varchar](255) NOT NULL,
	[BranchId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TrackId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intake]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intake](
	[IntakeId] [int] IDENTITY(1,1) NOT NULL,
	[IntakeName] [varchar](255) NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[TrackId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IntakeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](255) NULL,
	[LastName] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Role] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentId] [int] NOT NULL,
	[IntakeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SearchStudentsByIntakeOrTrack]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SearchStudentsByIntakeOrTrack]
AS
SELECT
    s.StudentId,
    u.FirstName,u.LastName,u.Email,
    i.IntakeName,
    t.TrackName
FROM Student s JOIN Intake i ON s.IntakeId = i.IntakeId
    JOIN Track t ON i.TrackId = t.TrackId
	,[User] u WHERE u.UserId=s.StudentId
GO
/****** Object:  Table [dbo].[Question]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionName] [varchar](255) NULL,
	[QuestionDetails] [text] NULL,
	[QuestionType] [varchar](50) NULL,
	[QuestionCorrectAnswer] [text] NULL,
	[CourseMinDegree] [int] NULL,
	[CourseId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ExamId] [int] IDENTITY(1,1) NOT NULL,
	[ExamType] [varchar](50) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[IntakeId] [int] NULL,
	[CourseInstructorId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExamQuestion]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamQuestion](
	[ExamQuestionId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionDegree] [int] NULL,
	[QuestionId] [int] NULL,
	[ExamId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamQuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentAssignedExam]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAssignedExam](
	[StudentAssignedExamId] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[ExamId] [int] NULL,
	[StudentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentAssignedExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentAnswer]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAnswer](
	[StudentAnswerId] [int] IDENTITY(1,1) NOT NULL,
	[StudentAnswerContent] [text] NULL,
	[ExamQuestionId] [int] NULL,
	[StudentAssignedExamId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentAnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[StudentExamResults]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentExamResults] AS
SELECT 
	e.ExamId,
	s.StudentId,
	u.FirstName + ' ' + u.LastName AS FullName,
	e.ExamType, e.StartTime, 
	SUM(CASE WHEN CAST(sa.StudentAnswerContent AS VARCHAR(MAX)) = CAST(q.QuestionCorrectAnswer AS VARCHAR(MAX)) 
	THEN eq.QuestionDegree ELSE 0 END) * 100.0 / SUM(eq.QuestionDegree) AS Percentage
FROM     
	dbo.StudentAnswer sa INNER JOIN dbo.ExamQuestion eq 
	ON sa.ExamQuestionId = eq.ExamQuestionId INNER JOIN dbo.Question q
	ON eq.QuestionId = q.QuestionId INNER JOIN dbo.StudentAssignedExam sae 
	ON sa.StudentAssignedExamId = sae.StudentAssignedExamId INNER JOIN dbo.Exam  e
	ON sae.ExamId = e.ExamId INNER JOIN dbo.Student s 
	ON sae.StudentId = s.StudentId INNER JOIN dbo.[User] u 
	ON s.StudentId = u.UserId
	GROUP BY e.ExamId, s.StudentId, u.FirstName, u.LastName, e.ExamType, e.StartTime
GO
/****** Object:  Table [dbo].[Course]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [varchar](255) NULL,
	[CourseDescription] [text] NULL,
	[CourseMaxDegree] [int] NULL,
	[CourseMinDegree] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[SearchCoursesByNameOrDescription]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SearchCoursesByNameOrDescription 
CREATE VIEW [dbo].[SearchCoursesByNameOrDescription] AS
SELECT 
    CourseId,
    CourseName,
    CourseDescription,
    CourseMaxDegree,
    CourseMinDegree
FROM 
    Course;
GO
/****** Object:  Table [dbo].[CourseInstructor]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseInstructor](
	[CourseInstructorId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CourseId] [int] NULL,
	[Year] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseInstructorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SearchExamsByTypeOrDate]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SearchExamsByTypeOrDate
CREATE VIEW [dbo].[SearchExamsByTypeOrDate] AS
SELECT 
    e.ExamId,
    e.ExamType,
    e.StartTime,
    e.EndTime,
    i.IntakeName,
    ci.UserId AS InstructorId,
    ci.CourseId
FROM 
    Exam e
JOIN 
    Intake i ON e.IntakeId = i.IntakeId
JOIN 
    CourseInstructor ci ON e.CourseInstructorId = ci.CourseInstructorId;
GO
/****** Object:  Table [dbo].[Departement]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departement](
	[DepartementId] [int] IDENTITY(1,1) NOT NULL,
	[DepartementName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[BranchId] [int] IDENTITY(1,1) NOT NULL,
	[BranchName] [varchar](255) NOT NULL,
	[DepartementId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BranchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SearchUsersByRoleOrDepartment]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SearchUsersByRoleOrDepartment
Create VIEW [dbo].[SearchUsersByRoleOrDepartment] AS
SELECT 
    u.UserId,
    u.FirstName,
    u.LastName,
    u.Email,
    u.Role,
    s.StudentId,
    i.IntakeName,
    t.TrackName,
    b.BranchName,
    d.DepartementName
FROM 
    [User] u
LEFT JOIN 
    Student s ON u.UserId = s.StudentId
LEFT JOIN 
    Intake i ON s.IntakeId = i.IntakeId
LEFT JOIN 
    Track t ON i.TrackId = t.TrackId
LEFT JOIN 
    Branch b ON t.BranchId = b.BranchId
LEFT JOIN 
    Departement d ON b.DepartementId = d.DepartementId;
GO
/****** Object:  View [dbo].[SearchQuestionsByCourseOrType]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SearchQuestionsByCourseOrType]
AS
SELECT
    q.QuestionId, q.QuestionName, q.QuestionDetails, q.QuestionType, q.QuestionCorrectAnswer, q.CourseMinDegree,
    c.CourseName
FROM
    Question q JOIN Course c 
	ON q.CourseId = c.CourseId
GO
/****** Object:  Table [dbo].[QuestionChoices]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionChoices](
	[QuestionChoiceId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NULL,
	[Choice] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionChoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAuth]    Script Date: 6/21/2024 7:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAuth](
	[UserId] [int] NOT NULL,
	[Password] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Branch] ON 

INSERT [dbo].[Branch] ([BranchId], [BranchName], [DepartementId]) VALUES (1, N'Network Engineering', 1)
INSERT [dbo].[Branch] ([BranchId], [BranchName], [DepartementId]) VALUES (2, N'Quality Assurance', 2)
INSERT [dbo].[Branch] ([BranchId], [BranchName], [DepartementId]) VALUES (3, N'Cyber Security', 3)
INSERT [dbo].[Branch] ([BranchId], [BranchName], [DepartementId]) VALUES (4, N'Data Science', 1)
INSERT [dbo].[Branch] ([BranchId], [BranchName], [DepartementId]) VALUES (5, N'Data Analysis', 1)
INSERT [dbo].[Branch] ([BranchId], [BranchName], [DepartementId]) VALUES (6, N'Game Development', 1)
INSERT [dbo].[Branch] ([BranchId], [BranchName], [DepartementId]) VALUES (7, N'Project Mangement', 2)
INSERT [dbo].[Branch] ([BranchId], [BranchName], [DepartementId]) VALUES (8, N'Software Engineering', 1)
SET IDENTITY_INSERT [dbo].[Branch] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseId], [CourseName], [CourseDescription], [CourseMaxDegree], [CourseMinDegree]) VALUES (1, N'Math 102', N'Intermediate Math Course', 100, 60)
INSERT [dbo].[Course] ([CourseId], [CourseName], [CourseDescription], [CourseMaxDegree], [CourseMinDegree]) VALUES (2, N'Web Development', N'Introduction to web development', 100, 50)
INSERT [dbo].[Course] ([CourseId], [CourseName], [CourseDescription], [CourseMaxDegree], [CourseMinDegree]) VALUES (3, N'Software Testing', N'Introduction to software testing', 100, 50)
INSERT [dbo].[Course] ([CourseId], [CourseName], [CourseDescription], [CourseMaxDegree], [CourseMinDegree]) VALUES (4, N'Math 101', N'Basic Math Course', 100, 60)
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseInstructor] ON 

INSERT [dbo].[CourseInstructor] ([CourseInstructorId], [UserId], [CourseId], [Year]) VALUES (1, 3, 1, 2023)
INSERT [dbo].[CourseInstructor] ([CourseInstructorId], [UserId], [CourseId], [Year]) VALUES (2, 3, 2, 2024)
INSERT [dbo].[CourseInstructor] ([CourseInstructorId], [UserId], [CourseId], [Year]) VALUES (3, 3, 3, 2024)
SET IDENTITY_INSERT [dbo].[CourseInstructor] OFF
GO
SET IDENTITY_INSERT [dbo].[Departement] ON 

INSERT [dbo].[Departement] ([DepartementId], [DepartementName]) VALUES (1, N'Computer Science')
INSERT [dbo].[Departement] ([DepartementId], [DepartementName]) VALUES (2, N'Software Engineering')
INSERT [dbo].[Departement] ([DepartementId], [DepartementName]) VALUES (3, N'Information Technology')
SET IDENTITY_INSERT [dbo].[Departement] OFF
GO
SET IDENTITY_INSERT [dbo].[Exam] ON 

INSERT [dbo].[Exam] ([ExamId], [ExamType], [StartTime], [EndTime], [IntakeId], [CourseInstructorId]) VALUES (1, N'Corrective', CAST(N'2023-10-01T10:00:00.000' AS DateTime), CAST(N'2023-10-01T12:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Exam] ([ExamId], [ExamType], [StartTime], [EndTime], [IntakeId], [CourseInstructorId]) VALUES (2, N'Normal', CAST(N'2024-05-01T10:00:00.000' AS DateTime), CAST(N'2024-05-01T12:00:00.000' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Exam] OFF
GO
SET IDENTITY_INSERT [dbo].[ExamQuestion] ON 

INSERT [dbo].[ExamQuestion] ([ExamQuestionId], [QuestionDegree], [QuestionId], [ExamId]) VALUES (2, 40, 3, 2)
INSERT [dbo].[ExamQuestion] ([ExamQuestionId], [QuestionDegree], [QuestionId], [ExamId]) VALUES (4, 20, 4, 2)
INSERT [dbo].[ExamQuestion] ([ExamQuestionId], [QuestionDegree], [QuestionId], [ExamId]) VALUES (5, 40, 5, 2)
SET IDENTITY_INSERT [dbo].[ExamQuestion] OFF
GO
SET IDENTITY_INSERT [dbo].[Intake] ON 

INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (1, N'Spring 2024', CAST(N'2024-01-01' AS Date), CAST(N'2024-04-30' AS Date), 1)
INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (2, N'Spring 2024', CAST(N'2024-01-15' AS Date), CAST(N'2024-05-01' AS Date), 2)
INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (3, N'Summer 2024', CAST(N'2024-06-01' AS Date), CAST(N'2024-08-15' AS Date), 3)
INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (4, N'Fall 2024', CAST(N'2024-09-01' AS Date), CAST(N'2024-12-20' AS Date), 1)
INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (5, N'Fall 2024', CAST(N'2024-09-01' AS Date), CAST(N'2024-12-31' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Intake] OFF
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (1, N'What is software engineering?', N'Explain the field of software engineering and its importance.', N'Essay', N'Software engineering is the systematic application of engineering approaches to the development of software.', 50, 1)
INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (2, N'Describe the concept of data encapsulation in OOP.', N'Explain data encapsulation with an example.', N'Essay', N'Data encapsulation is the bundling of data with the methods that operate on that data.', 50, 1)
INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (3, N'What are the main differences between HTTP and HTTPS?', N'Describe the differences and the importance of HTTPS.', N'Essay', N'HTTPS is the secure version of HTTP, using encryption to increase security.', 50, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (4, N'True or False: HTML is a programming language.', N'HTML is used to create web pages and web applications.', N'True/False', N'False', 50, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (5, N'Which of the following is a version control system?', N'Choose the correct version control system from the options below.', N'MCQ', N'Git', 50, 2)
SET IDENTITY_INSERT [dbo].[Question] OFF
GO
SET IDENTITY_INSERT [dbo].[QuestionChoices] ON 

INSERT [dbo].[QuestionChoices] ([QuestionChoiceId], [QuestionId], [Choice]) VALUES (1, 5, N'Git')
INSERT [dbo].[QuestionChoices] ([QuestionChoiceId], [QuestionId], [Choice]) VALUES (2, 5, N'vscode')
INSERT [dbo].[QuestionChoices] ([QuestionChoiceId], [QuestionId], [Choice]) VALUES (3, 5, N'sqlserver')
SET IDENTITY_INSERT [dbo].[QuestionChoices] OFF
GO
INSERT [dbo].[Student] ([StudentId], [IntakeId]) VALUES (4, 1)
INSERT [dbo].[Student] ([StudentId], [IntakeId]) VALUES (5, 2)
INSERT [dbo].[Student] ([StudentId], [IntakeId]) VALUES (6, 2)
GO
SET IDENTITY_INSERT [dbo].[StudentAnswer] ON 

INSERT [dbo].[StudentAnswer] ([StudentAnswerId], [StudentAnswerContent], [ExamQuestionId], [StudentAssignedExamId]) VALUES (2, N'HTTPS is the secure version of HTTP, using encryption to increase security.', 2, 2)
INSERT [dbo].[StudentAnswer] ([StudentAnswerId], [StudentAnswerContent], [ExamQuestionId], [StudentAssignedExamId]) VALUES (4, N'True', 4, 2)
INSERT [dbo].[StudentAnswer] ([StudentAnswerId], [StudentAnswerContent], [ExamQuestionId], [StudentAssignedExamId]) VALUES (5, N'Git', 5, 2)
SET IDENTITY_INSERT [dbo].[StudentAnswer] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentAssignedExam] ON 

INSERT [dbo].[StudentAssignedExam] ([StudentAssignedExamId], [StartTime], [EndTime], [ExamId], [StudentId]) VALUES (1, CAST(N'2023-10-01T10:00:00.000' AS DateTime), CAST(N'2023-10-01T12:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[StudentAssignedExam] ([StudentAssignedExamId], [StartTime], [EndTime], [ExamId], [StudentId]) VALUES (2, CAST(N'2024-05-01T10:00:00.000' AS DateTime), CAST(N'2024-05-01T12:00:00.000' AS DateTime), 2, 5)
SET IDENTITY_INSERT [dbo].[StudentAssignedExam] OFF
GO
SET IDENTITY_INSERT [dbo].[Track] ON 

INSERT [dbo].[Track] ([TrackId], [TrackName], [BranchId]) VALUES (1, N'Cybersecurity', 1)
INSERT [dbo].[Track] ([TrackId], [TrackName], [BranchId]) VALUES (2, N'Mobile Application Development', 1)
INSERT [dbo].[Track] ([TrackId], [TrackName], [BranchId]) VALUES (3, N'Automation Testing', 2)
INSERT [dbo].[Track] ([TrackId], [TrackName], [BranchId]) VALUES (4, N'Manual Testing', 2)
INSERT [dbo].[Track] ([TrackId], [TrackName], [BranchId]) VALUES (5, N'Network Security', 3)
INSERT [dbo].[Track] ([TrackId], [TrackName], [BranchId]) VALUES (6, N'Data Analysis', 4)
INSERT [dbo].[Track] ([TrackId], [TrackName], [BranchId]) VALUES (7, N'Web Development ', 3)
INSERT [dbo].[Track] ([TrackId], [TrackName], [BranchId]) VALUES (8, N'Artificial Intelligence', 1)
SET IDENTITY_INSERT [dbo].[Track] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (2, N'Abdelrahman', N'Shabaan', N'Abdelrahman.Shabaan@gmail.com', N'Admin')
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (3, N'Ahmed', N'Maher', N'Ahmed.Maher@gmail.com', N'Instructor')
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (4, N'Ahmed', N'Abdelaal', N'Ahmed.Abdelaal@gmail.com', N'Student')
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (5, N'Noha', N'Gamal', N'Noha.Gamal@gmail.com', N'Student')
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (6, N'Nour', N'Adel', N'Nour.Adel@example.com', N'Student')
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (7, N'Noura', N'Adel', N'Noura.Adel@example.com', N'Student')
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (8, N'Noura', N'Adel', N'Noura.Adel@example.com', N'Student')
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (9, N'Noura', N'Adel', N'Noura.Adel@example.com', N'Student')
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [Email], [Role]) VALUES (10, N'Noura', N'Adel', N'Noura.Adel@example.com', N'Student')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (2, N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3')
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (3, N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3')
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (4, N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3')
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (5, N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3')
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (6, N'08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394')
GO
ALTER TABLE [dbo].[Branch]  WITH CHECK ADD FOREIGN KEY([DepartementId])
REFERENCES [dbo].[Departement] ([DepartementId])
GO
ALTER TABLE [dbo].[CourseInstructor]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[CourseInstructor]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([CourseInstructorId])
REFERENCES [dbo].[CourseInstructor] ([CourseInstructorId])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([IntakeId])
REFERENCES [dbo].[Intake] ([IntakeId])
GO
ALTER TABLE [dbo].[ExamQuestion]  WITH CHECK ADD FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exam] ([ExamId])
GO
ALTER TABLE [dbo].[ExamQuestion]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Intake]  WITH CHECK ADD FOREIGN KEY([TrackId])
REFERENCES [dbo].[Track] ([TrackId])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[QuestionChoices]  WITH CHECK ADD FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([IntakeId])
REFERENCES [dbo].[Intake] ([IntakeId])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[StudentAnswer]  WITH CHECK ADD FOREIGN KEY([ExamQuestionId])
REFERENCES [dbo].[ExamQuestion] ([ExamQuestionId])
GO
ALTER TABLE [dbo].[StudentAnswer]  WITH CHECK ADD FOREIGN KEY([StudentAssignedExamId])
REFERENCES [dbo].[StudentAssignedExam] ([StudentAssignedExamId])
GO
ALTER TABLE [dbo].[StudentAssignedExam]  WITH CHECK ADD FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exam] ([ExamId])
GO
ALTER TABLE [dbo].[StudentAssignedExam]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([StudentId])
GO
ALTER TABLE [dbo].[Track]  WITH CHECK ADD FOREIGN KEY([BranchId])
REFERENCES [dbo].[Branch] ([BranchId])
GO
ALTER TABLE [dbo].[UserAuth]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
/****** Object:  StoredProcedure [dbo].[AddNewBranch]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewBranch]
    @BranchName VARCHAR(100),
    @DepartementId INT
AS
BEGIN
    INSERT INTO Branch (BranchName, DepartementId)
    VALUES (@BranchName, @DepartementId)
END
GO
/****** Object:  StoredProcedure [dbo].[AddNewCourse]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Add new course procedure 
Create PROCEDURE [dbo].[AddNewCourse] 
(
  @CourseName nvarchar(255),
  @Description nvarchar(max),
  @MaxDegree float,
  @MinDegree float
)

AS
BEGIN
  -- Insert new course details into Courses table
  INSERT INTO Course (CourseName, CourseDescription, CourseMaxDegree, CourseMinDegree)
  VALUES (@CourseName, @Description, @MaxDegree, @MinDegree);
END;
GO
/****** Object:  StoredProcedure [dbo].[AddNewIntake]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewIntake]
    @IntakeName VARCHAR(100),
    @StartDate DATE,
    @EndDate DATE,
    @TrackId INT
AS
BEGIN
    INSERT INTO Intake (IntakeName, StartDate, EndDate, TrackId)
    VALUES (@IntakeName, @StartDate, @EndDate, @TrackId)
END
GO
/****** Object:  StoredProcedure [dbo].[AddNewTrack]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewTrack]
    @TrackName VARCHAR(100),
    @BranchId INT
AS
BEGIN
    INSERT INTO Track (TrackName, BranchId)
    VALUES (@TrackName, @BranchId)
END
GO
/****** Object:  StoredProcedure [dbo].[AddQuestionsToExam]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Add questions to exam
CREATE PROCEDURE [dbo].[AddQuestionsToExam]
    @ExamId INT,
    @QuestionId INT,
    @QuestionDegree INT

as
BEGIN
    INSERT INTO ExamQuestion (ExamId, QuestionId, QuestionDegree)
    VALUES (@ExamId, @QuestionId, @QuestionDegree);
END;
GO
/****** Object:  StoredProcedure [dbo].[AssignInstructorToCourse]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Assign Instructor to Course
CREATE PROCEDURE [dbo].[AssignInstructorToCourse]
    @UserId INT,
    @CourseId INT,
    @Year INT


AS
BEGIN
    INSERT INTO CourseInstructor (UserId, CourseId, Year)
    VALUES (@UserId, @CourseId, @Year);
END;
GO
/****** Object:  StoredProcedure [dbo].[AssignStudentToExam]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AssignStudentToExam]
    @StudentAssignedExamId INT,
    @StartTime DATETIME,
    @EndTime DATETIME,
    @ExamId INT,
    @StudentId INT
AS
BEGIN
    INSERT INTO StudentAssignedExam (
        StudentAssignedExamId,
        StartTime,
        EndTime,
        ExamId,
        StudentId
    )
    VALUES (
        @StudentAssignedExamId,
        @StartTime,
        @EndTime,
        @ExamId,
        @StudentId
    )
END
GO
/****** Object:  StoredProcedure [dbo].[CreateExam]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create new exam 
CREATE PROCEDURE [dbo].[CreateExam]
    @ExamType VARCHAR(50),
    @StartTime DATETIME,
    @EndTime DATETIME,
    @IntakeId INT,
    @CourseInstructorId INT
 
as
BEGIN
    INSERT INTO Exam (ExamType, StartTime, EndTime, IntakeId, CourseInstructorId)
    VALUES (@ExamType, @StartTime, @EndTime, @IntakeId, @CourseInstructorId);
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteCourse]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Delete Course
CREATE PROCEDURE [dbo].[DeleteCourse]
    @CourseId INT

AS
BEGIN
    -- Deleting all related questions to the course
    DELETE FROM Question
    WHERE CourseId = @CourseId;

    -- Deleting all related course instructor records
    DELETE FROM CourseInstructor
    WHERE CourseId = @CourseId;

    -- Deleting the course
    DELETE FROM Course
    WHERE CourseId = @CourseId;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteExam]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete Exam
CREATE PROCEDURE [dbo].[DeleteExam]
    @ExamId INT

AS
BEGIN
    -- Deleting all related student answers for the exam
    DELETE sa
    FROM StudentAnswer sa
    INNER JOIN ExamQuestion eq ON sa.ExamQuestionId = eq.ExamQuestionId
    WHERE eq.ExamId = @ExamId;

    -- Deleting all related exam questions
    DELETE FROM ExamQuestion
    WHERE ExamId = @ExamId;

    -- Deleting the exam
    DELETE FROM Exam
    WHERE ExamId = @ExamId;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteStudent]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteStudent]
    @StudentId INT
AS
BEGIN
 
    DELETE FROM StudentAssignedExam
    WHERE StudentId = @StudentId

    DELETE FROM UserAuth
    WHERE UserId = @StudentId

    DELETE FROM [User]
    WHERE UserId = @StudentId AND role = 'Student'

    DELETE FROM Student
    WHERE StudentId = @StudentId

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete users 
CREATE PROCEDURE [dbo].[DeleteUser]
    @UserId INT

AS
BEGIN
    -- Deleting the user authentication details
    DELETE FROM UserAuth
    WHERE UserId = @UserId;

    -- Deleting the user
    DELETE FROM [User]
    WHERE UserId = @UserId;
END;
GO
/****** Object:  StoredProcedure [dbo].[EditBranch]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditBranch]
    @BranchId INT,
    @BranchName VARCHAR(100),
    @DepartementId INT
AS
BEGIN
    UPDATE Branch
    SET BranchName = @BranchName,
        DepartementId = @DepartementId
    WHERE BranchId = @BranchId
END
GO
/****** Object:  StoredProcedure [dbo].[EditIntake]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditIntake]
    @IntakeId INT,
    @IntakeName VARCHAR(100),
    @StartDate DATE,
    @EndDate DATE,
    @TrackId INT
AS
BEGIN

    UPDATE Intake
    SET IntakeName = @IntakeName,
        StartDate = @StartDate,
        EndDate = @EndDate,
        TrackId = @TrackId
    WHERE IntakeId = @IntakeId
END
GO
/****** Object:  StoredProcedure [dbo].[EditTrack]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditTrack]
    @TrackId INT,
    @TrackName VARCHAR(100),
    @BranchId INT
AS
BEGIN
    UPDATE Track
    SET TrackName = @TrackName,
        BranchId = @BranchId
    WHERE TrackId = @TrackId
END
GO
/****** Object:  StoredProcedure [dbo].[RecordStudentAnswers]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- record student answer
CREATE PROCEDURE [dbo].[RecordStudentAnswers]
    @StudentAssignedExamId INT,
    @ExamQuestionId INT,
    @StudentAnswerContent TEXT
 
as
BEGIN
    INSERT INTO StudentAnswer (StudentAssignedExamId, ExamQuestionId, StudentAnswerContent)
    VALUES (@StudentAssignedExamId, @ExamQuestionId, @StudentAnswerContent);
END;
GO
/****** Object:  StoredProcedure [dbo].[RegisterStudent]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegisterStudent]
    @StudentId INT,
    @IntakeId INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Password VARCHAR(50)
AS
BEGIN
    DECLARE @HashedPassword VARCHAR(256);
    SET @HashedPassword = CONVERT(VARCHAR(256), HASHBYTES('SHA2_256', @Password), 2);

	-- Insert into User table
	INSERT INTO [User] (FirstName, LastName, Email, Role) VALUES 
	(@FirstName, @LastName, @Email, 'Student')

	-- Insert into Student table
	INSERT INTO Student (StudentId, IntakeId) VALUES 
	((SELECT UserId FROM [User] WHERE Email = @Email), @IntakeId)

	-- Insert into UserAuth Table
	INSERT INTO UserAuth (UserId, Password)
    VALUES ((SELECT UserId FROM [User] WHERE Email = @Email), @HashedPassword)
END
GO
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Register new user
Create PROCEDURE [dbo].[RegisterUser]
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @Email VARCHAR(255),
    @Role VARCHAR(50),
    @Password VARCHAR(255)

AS
BEGIN
    DECLARE @UserId INT;
    DECLARE @HashedPassword VARCHAR(256);

    SET @HashedPassword = CONVERT(VARCHAR(256), HASHBYTES('SHA2_256', @Password), 2);

    INSERT INTO [User] (FirstName, LastName, Email, Role)
    VALUES (@FirstName, @LastName, @Email, @Role);

    SET @UserId = SCOPE_IDENTITY();

    INSERT INTO UserAuth (UserId, Password)
    VALUES (@UserId, @HashedPassword);
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateCourseDetails]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update Course Details
CREATE PROCEDURE [dbo].[UpdateCourseDetails]
    @CourseId INT,
    @CourseName VARCHAR(255),
    @CourseDescription TEXT,
    @CourseMaxDegree INT,
    @CourseMinDegree INT


AS
BEGIN
    UPDATE Course
    SET CourseName = @CourseName,
        CourseDescription = @CourseDescription,
        CourseMaxDegree = @CourseMaxDegree,
        CourseMinDegree = @CourseMinDegree
    WHERE CourseId = @CourseId;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateExamDetails]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update exam details`
Create PROCEDURE [dbo].[UpdateExamDetails]
    @ExamId INT,
    @ExamType VARCHAR(50),
    @StartTime DATETIME,
    @EndTime DATETIME

AS
BEGIN
    UPDATE Exam
    SET ExamType = @ExamType,
        StartTime = @StartTime,
        EndTime = @EndTime
    WHERE ExamId = @ExamId;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateStudentDetails]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStudentDetails]
    @StudentId INT,
    @IntakeId INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
	@Password VARCHAR(50)
AS
BEGIN
    DECLARE @HashedPassword VARCHAR(256);
    SET @HashedPassword = CONVERT(VARCHAR(256), HASHBYTES('SHA2_256', @Password), 2);
    UPDATE Student
    SET IntakeId = @IntakeId
    WHERE StudentId = @StudentId

    UPDATE [User]
    SET FirstName = @FirstName, LastName = @LastName, Email = @Email
    WHERE UserId = @StudentId AND role = 'Student'

    UPDATE UserAuth
    SET Password = @HashedPassword
    WHERE UserId = @StudentId
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserInfo]    Script Date: 6/21/2024 7:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Update user Information
CREATE PROCEDURE [dbo].[UpdateUserInfo]
    @UserId INT,
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @Email VARCHAR(255),
    @Role VARCHAR(50)

AS
BEGIN
    UPDATE [User]
    SET FirstName = @FirstName,
        LastName = @LastName,
        Email = @Email,
        Role = @Role
    WHERE UserId = @UserId;
END;
GO
USE [master]
GO
ALTER DATABASE [ExSys] SET  READ_WRITE 
GO
