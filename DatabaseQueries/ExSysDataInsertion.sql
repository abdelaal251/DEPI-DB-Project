USE [ExSys]
GO
SET IDENTITY_INSERT [dbo].[Departement] ON 

INSERT [dbo].[Departement] ([DepartementId], [DepartementName]) VALUES (1, N'Computer Science')
INSERT [dbo].[Departement] ([DepartementId], [DepartementName]) VALUES (2, N'Software Engineering')
INSERT [dbo].[Departement] ([DepartementId], [DepartementName]) VALUES (3, N'Information Technology')
SET IDENTITY_INSERT [dbo].[Departement] OFF
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
SET IDENTITY_INSERT [dbo].[Intake] ON 

INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (1, N'Spring 2024', CAST(N'2024-01-01' AS Date), CAST(N'2024-04-30' AS Date), 1)
INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (2, N'Spring 2024', CAST(N'2024-01-15' AS Date), CAST(N'2024-05-01' AS Date), 2)
INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (3, N'Summer 2024', CAST(N'2024-06-01' AS Date), CAST(N'2024-08-15' AS Date), 3)
INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (4, N'Fall 2024', CAST(N'2024-09-01' AS Date), CAST(N'2024-12-20' AS Date), 1)
INSERT [dbo].[Intake] ([IntakeId], [IntakeName], [StartDate], [EndDate], [TrackId]) VALUES (5, N'Fall 2024', CAST(N'2024-09-01' AS Date), CAST(N'2024-12-31' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Intake] OFF
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
INSERT [dbo].[Student] ([StudentId], [IntakeId]) VALUES (4, 1)
INSERT [dbo].[Student] ([StudentId], [IntakeId]) VALUES (5, 2)
INSERT [dbo].[Student] ([StudentId], [IntakeId]) VALUES (6, 2)
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
SET IDENTITY_INSERT [dbo].[Exam] ON 

INSERT [dbo].[Exam] ([ExamId], [ExamType], [StartTime], [EndTime], [IntakeId], [CourseInstructorId]) VALUES (1, N'Corrective', CAST(N'2023-10-01T10:00:00.000' AS DateTime), CAST(N'2023-10-01T12:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Exam] ([ExamId], [ExamType], [StartTime], [EndTime], [IntakeId], [CourseInstructorId]) VALUES (2, N'Normal', CAST(N'2024-05-01T10:00:00.000' AS DateTime), CAST(N'2024-05-01T12:00:00.000' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Exam] OFF
GO
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (2, N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3')
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (3, N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3')
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (4, N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3')
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (5, N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3')
INSERT [dbo].[UserAuth] ([UserId], [Password]) VALUES (6, N'08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394')
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (1, N'What is software engineering?', N'Explain the field of software engineering and its importance.', N'Essay', N'Software engineering is the systematic application of engineering approaches to the development of software.', 50, 1)
INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (2, N'Describe the concept of data encapsulation in OOP.', N'Explain data encapsulation with an example.', N'Essay', N'Data encapsulation is the bundling of data with the methods that operate on that data.', 50, 1)
INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (3, N'What are the main differences between HTTP and HTTPS?', N'Describe the differences and the importance of HTTPS.', N'Essay', N'HTTPS is the secure version of HTTP, using encryption to increase security.', 50, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (4, N'True or False: HTML is a programming language.', N'HTML is used to create web pages and web applications.', N'True/False', N'False', 50, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionName], [QuestionDetails], [QuestionType], [QuestionCorrectAnswer], [CourseMinDegree], [CourseId]) VALUES (5, N'Which of the following is a version control system?', N'Choose the correct version control system from the options below.', N'MCQ', N'Git', 50, 2)
SET IDENTITY_INSERT [dbo].[Question] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentAssignedExam] ON 

INSERT [dbo].[StudentAssignedExam] ([StudentAssignedExamId], [StartTime], [EndTime], [ExamId], [StudentId]) VALUES (1, CAST(N'2023-10-01T10:00:00.000' AS DateTime), CAST(N'2023-10-01T12:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[StudentAssignedExam] ([StudentAssignedExamId], [StartTime], [EndTime], [ExamId], [StudentId]) VALUES (2, CAST(N'2024-05-01T10:00:00.000' AS DateTime), CAST(N'2024-05-01T12:00:00.000' AS DateTime), 2, 5)
SET IDENTITY_INSERT [dbo].[StudentAssignedExam] OFF
GO
SET IDENTITY_INSERT [dbo].[ExamQuestion] ON 

INSERT [dbo].[ExamQuestion] ([ExamQuestionId], [QuestionDegree], [QuestionId], [ExamId]) VALUES (2, 40, 3, 2)
INSERT [dbo].[ExamQuestion] ([ExamQuestionId], [QuestionDegree], [QuestionId], [ExamId]) VALUES (4, 20, 4, 2)
INSERT [dbo].[ExamQuestion] ([ExamQuestionId], [QuestionDegree], [QuestionId], [ExamId]) VALUES (5, 40, 5, 2)
SET IDENTITY_INSERT [dbo].[ExamQuestion] OFF
GO
SET IDENTITY_INSERT [dbo].[QuestionChoices] ON 

INSERT [dbo].[QuestionChoices] ([QuestionChoiceId], [QuestionId], [Choice]) VALUES (1, 5, N'Git')
INSERT [dbo].[QuestionChoices] ([QuestionChoiceId], [QuestionId], [Choice]) VALUES (2, 5, N'vscode')
INSERT [dbo].[QuestionChoices] ([QuestionChoiceId], [QuestionId], [Choice]) VALUES (3, 5, N'sqlserver')
SET IDENTITY_INSERT [dbo].[QuestionChoices] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentAnswer] ON 

INSERT [dbo].[StudentAnswer] ([StudentAnswerId], [StudentAnswerContent], [ExamQuestionId], [StudentAssignedExamId]) VALUES (2, N'HTTPS is the secure version of HTTP, using encryption to increase security.', 2, 2)
INSERT [dbo].[StudentAnswer] ([StudentAnswerId], [StudentAnswerContent], [ExamQuestionId], [StudentAssignedExamId]) VALUES (4, N'True', 4, 2)
INSERT [dbo].[StudentAnswer] ([StudentAnswerId], [StudentAnswerContent], [ExamQuestionId], [StudentAssignedExamId]) VALUES (5, N'Git', 5, 2)
SET IDENTITY_INSERT [dbo].[StudentAnswer] OFF
GO
