--Procedures
--Register a new student by inserting their details into the Student table & user table & UserAuth table

CREATE PROCEDURE RegisterStudent
    @StudentId INT,
    @IntakeId INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
	@Password VARCHAR(50),
    @Role VARCHAR(50)
AS
BEGIN
    
    INSERT INTO Student (StudentId, IntakeId)
    VALUES (@StudentId, @IntakeId);

    INSERT INTO [User] (UserId, FirstName, LastName, Email, Role, Type)
    VALUES (@StudentId, @FirstName, @LastName, @Email, @Role, 'Student');
	 
    INSERT INTO UserAuth (UserId, Password)
    VALUES (@StudentId, @Password)

END

GO
--Assign a student to an exam by inserting a record into the StudentAssignedExam table

CREATE PROCEDURE AssignStudentToExam
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

--Update student details into the Student table & user table & UserAuth table

CREATE PROCEDURE UpdateStudentDetails
    @StudentId INT,
    @IntakeId INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
	@Password VARCHAR(50)
AS
BEGIN

    UPDATE Student
    SET IntakeId = @IntakeId
    WHERE StudentId = @StudentId

    UPDATE [User]
    SET FirstName = @FirstName, LastName = @LastName, Email = @Email
    WHERE UserId = @StudentId AND Type = 'Student'

    UPDATE UserAuth
    SET Password = @Password
    WHERE UserId = @StudentId
END
GO

--Remove a student from the system by deleting records from the Student, user, userauth  and StudentAssignedExam tables.

CREATE PROCEDURE DeleteStudent
    @StudentId INT
AS
BEGIN
 
    DELETE FROM StudentAssignedExam
    WHERE StudentId = @StudentId

    DELETE FROM UserAuth
    WHERE UserId = @StudentId

    DELETE FROM [User]
    WHERE UserId = @StudentId AND Type = 'Student'

    DELETE FROM Student
    WHERE StudentId = @StudentId

END
GO

--Views
--Display students filtered by their intake or track

CREATE VIEW SearchStudentsByIntakeOrTrack
AS
SELECT
    s.StudentId,
    u.FirstName,u.LastName,u.Email,
    i.IntakeName,
    t.TrackName
FROM
    [User] u,
	Student s JOIN Intake i 
	ON s.IntakeId = i.IntakeId
    JOIN Track t 
	ON i.TrackId = t.TrackId
GO 

--Display questions filtered by the course they belong to or the type of question

CREATE VIEW SearchQuestionsByCourseOrType
AS
SELECT
    q.QuestionId, q.QuestionName, q.QuestionDetails, q.QuestionType, q.QuestionCorrectAnswer, q.CourseMinDegree,
    c.CourseName
FROM
    Question q JOIN Course c 
	ON q.CourseId = c.CourseId
GO

--Display the results of exams for students, including the questions, correct answers, and student answers
CREATE VIEW ViewExamResultsForStudents
AS
SELECT
    sa.StudentAssignedExamId,
    e.ExamType, e.StartTime, e.EndTime,
    q.QuestionName, q.QuestionCorrectAnswer,
    sc.StudentAnswerContent
FROM
    StudentAssignedExam sa JOIN Exam e 
	ON sa.ExamId = e.ExamId
    JOIN ExamQuestion eq 
	ON sa.ExamId = eq.ExamId
    JOIN Question q 
	ON eq.QuestionId = q.QuestionId
    JOIN StudentAnswer sc 
	ON eq.ExamQuestionId = sc.ExamQuestionId AND sa.StudentAssignedExamId = sc.StudentAssignedExamId

