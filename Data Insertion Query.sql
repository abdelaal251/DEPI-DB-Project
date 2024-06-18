USE ExaminationSystem;
GO

-- Insert into Departement
INSERT INTO Departement (DepartementName) VALUES 
('Computer Science'),
('Software Engineering'),
('Information Technology');

-- Insert into Branch
INSERT INTO Branch (BranchName, DepartementId) VALUES 
('Software Development', 2),
('Quality Assurance', 2),
('Cyber Security', 3),
('Data Science', 1);

-- Insert into Track
INSERT INTO Track (TrackName, BranchId) VALUES 
('Full Stack Development', 1),
('Mobile Application Development', 1),
('Automation Testing', 2),
('Manual Testing', 2),
('Network Security', 3),
('Data Analysis', 4);

-- Insert into Intake
INSERT INTO Intake (IntakeName, StartDate, EndDate, TrackId) VALUES 
('Fall 2023', '2023-09-01', '2023-12-15', 1),
('Spring 2024', '2024-01-15', '2024-05-01', 2),
('Summer 2024', '2024-06-01', '2024-08-15', 3);

-- Insert into User
INSERT INTO [User] (FirstName, LastName, Email, Role, Type) VALUES 
('Mansour', 'Elhussieny', 'Mansour.Elhussieny@gmail.com', 'Admin', 'Admin'),
('Abdelrahman', 'Shabaan', 'Abdelrahman.Shabaan@gmail.com', 'Admin', 'TrainingManager'),
('Ahmed', 'Maher', 'Ahmed.Maher@gmail.com', 'User', 'Instructor'),
('Ahmed', 'Abdelaal', 'Ahmed.Abdelaal@gmail.com', 'user', 'Student'),
('Noha', 'Gamal', 'Noha.Gamal@gmail.com', 'User', 'Student');

-- Insert into UserAuth
INSERT INTO UserAuth (UserId, Password) VALUES 
(1, 'hashedpassword1'),
(2, 'hashedpassword2'),
(3, 'hashedpassword3'),
(4, 'hashedpassword4'),
(5, 'hashedpassword5');

-- Insert into Course
INSERT INTO Course (CourseName, CourseDescription, CourseMaxDegree, CourseMinDegree) VALUES 
('Database Systems', 'Introduction to databases', 100, 50),
('Web Development', 'Introduction to web development', 100, 50),
('Software Testing', 'Introduction to software testing', 100, 50);

-- Insert into CourseInstructor
INSERT INTO CourseInstructor (UserId, CourseId, Year) VALUES 
(3, 1, 2023),
(3, 2, 2024),
(3, 3, 2024);

-- Insert into Student
INSERT INTO Student (IntakeId) VALUES 
(1),
(2),
(3);

-- Insert essay questions
INSERT INTO Question (QuestionName, QuestionDetails, QuestionType, QuestionCorrectAnswer, CourseMinDegree, CourseId) VALUES 
('What is software engineering?', 'Explain the field of software engineering and its importance.', 'Essay', 'Software engineering is the systematic application of engineering approaches to the development of software.', 50, 1),
('Describe the concept of data encapsulation in OOP.', 'Explain data encapsulation with an example.', 'Essay', 'Data encapsulation is the bundling of data with the methods that operate on that data.', 50, 1),
('What are the main differences between HTTP and HTTPS?', 'Describe the differences and the importance of HTTPS.', 'Essay', 'HTTPS is the secure version of HTTP, using encryption to increase security.', 50, 2),
('True or False: HTML is a programming language.', 'HTML is used to create web pages and web applications.', 'True/False', 'False', 50, 2),
('Which of the following is a version control system?', 'Choose the correct version control system from the options below.', 'MCQ', 'Git', 50, 2);

GO


-- Insert choices for the true/false question
INSERT INTO QuestionChoices (QuestionId, Choice) VALUES
(4, 'True'),
(4, 'False');
(5, 'A'),
(5, 'B'),
(5, 'C');
GO



-- Insert into Exam
INSERT INTO Exam (ExamType, StartTime, EndTime, IntakeId, CourseInstructorId) VALUES 
('Midterm', '2023-10-01 10:00:00', '2023-10-01 12:00:00', 1, 1),
('Final', '2024-05-01 10:00:00', '2024-05-01 12:00:00', 2, 2);

-- Insert into ExamQuestion
INSERT INTO ExamQuestion (QuestionDegree, QuestionId, ExamId) VALUES 
(10, 1, 1),
(20, 2, 2);

-- Insert into StudentAssignedExam
INSERT INTO StudentAssignedExam (StartTime, EndTime, ExamId, StudentId) VALUES 
('2023-10-01 10:00:00', '2023-10-01 12:00:00', 1, 1),
('2024-05-01 10:00:00', '2024-05-01 12:00:00', 2, 2);

-- Insert into StudentAnswer
INSERT INTO StudentAnswer (StudentAnswerContent, ExamQuestionId, StudentAssignedExamId) VALUES 
('SQL is Structured Query Language', 1, 1),
('HTML is HyperText Markup Language', 2, 2);
GO
