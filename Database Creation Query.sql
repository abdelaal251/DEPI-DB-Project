CREATE DATABASE ExaminationSystem;
go

USE ExaminationSystem;
GO

-- Departement Table
CREATE TABLE Departement (
    DepartementId INT PRIMARY KEY IDENTITY(1,1),
    DepartementName VARCHAR(255) NOT NULL
);
GO

-- Branch Table
CREATE TABLE Branch (
    BranchId INT PRIMARY KEY IDENTITY(1,1),
    BranchName VARCHAR(255) NOT NULL,
    DepartementId INT,
    FOREIGN KEY (DepartementId) REFERENCES Departement(DepartementId)
);
GO

-- Track Table
CREATE TABLE Track (
    TrackId INT PRIMARY KEY IDENTITY(1,1),
    TrackName VARCHAR(255) NOT NULL,
    BranchId INT,
    FOREIGN KEY (BranchId) REFERENCES Branch(BranchId)
);
GO

-- Intake Table
CREATE TABLE Intake (
    IntakeId INT PRIMARY KEY IDENTITY(1,1),
    IntakeName VARCHAR(255) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    TrackId INT,
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);
GO

-- User Table
CREATE TABLE [User] (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Role VARCHAR(50),
    Type VARCHAR(50)
);
GO

-- UserAuth Table
CREATE TABLE UserAuth (
    UserId INT PRIMARY KEY,
    Password VARCHAR(255),
    FOREIGN KEY (UserId) REFERENCES [User](UserId)
);
GO

-- Course Table
CREATE TABLE Course (
    CourseId INT PRIMARY KEY IDENTITY(1,1),
    CourseName VARCHAR(255),
    CourseDescription TEXT,
    CourseMaxDegree INT,
    CourseMinDegree INT
);
GO

-- CourseInstructor Table
CREATE TABLE CourseInstructor (
    CourseInstructorId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT,
    CourseId INT,
    Year INT,
    FOREIGN KEY (UserId) REFERENCES [User](UserId),
    FOREIGN KEY (CourseId) REFERENCES Course(CourseId)
);
GO

-- Student Table
CREATE TABLE Student (
    StudentId INT PRIMARY KEY IDENTITY(1,1),
    IntakeId INT,
    FOREIGN KEY (IntakeId) REFERENCES Intake(IntakeId)
);
GO

-- Question Table
CREATE TABLE Question (
    QuestionId INT PRIMARY KEY IDENTITY(1,1),
    QuestionName VARCHAR(255),
    QuestionDetails TEXT,
    QuestionType VARCHAR(50),
    QuestionCorrectAnswer TEXT,
    CourseMinDegree INT,
    CourseId INT,
    FOREIGN KEY (CourseId) REFERENCES Course(CourseId)
);
GO

-- Exam Table
CREATE TABLE Exam (
    ExamId INT PRIMARY KEY IDENTITY(1,1),
    ExamType VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    IntakeId INT,
    CourseInstructorId INT,
    FOREIGN KEY (IntakeId) REFERENCES Intake(IntakeId),
    FOREIGN KEY (CourseInstructorId) REFERENCES CourseInstructor(CourseInstructorId)
);
GO

-- ExamQuestion Table
CREATE TABLE ExamQuestion (
    ExamQuestionId INT PRIMARY KEY IDENTITY(1,1),
    QuestionDegree INT,
    QuestionId INT,
    ExamId INT,
    FOREIGN KEY (QuestionId) REFERENCES Question(QuestionId),
    FOREIGN KEY (ExamId) REFERENCES Exam(ExamId)
);
GO

-- StudentAssignedExam Table
CREATE TABLE StudentAssignedExam (
    StudentAssignedExamId INT PRIMARY KEY IDENTITY(1,1),
    StartTime DATETIME,
    EndTime DATETIME,
    ExamId INT,
    StudentId INT,
    FOREIGN KEY (ExamId) REFERENCES Exam(ExamId),
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
);
GO

-- StudentAnswer Table
CREATE TABLE StudentAnswer (
    StudentAnswerId INT PRIMARY KEY IDENTITY(1,1),
    StudentAnswerContent TEXT,
    ExamQuestionId INT,
    StudentAssignedExamId INT,
    FOREIGN KEY (ExamQuestionId) REFERENCES ExamQuestion(ExamQuestionId),
    FOREIGN KEY (StudentAssignedExamId) REFERENCES StudentAssignedExam(StudentAssignedExamId)
);
GO

CREATE TABLE QuestionChoices (
    QuestionChoiceId INT PRIMARY KEY IDENTITY(1,1),
    QuestionId INT,
    Choice VARCHAR(255),
    FOREIGN KEY (QuestionId) REFERENCES Question(QuestionId)
);
GO

