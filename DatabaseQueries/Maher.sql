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


-- Assign Instructor to Course
CREATE PROCEDURE AssignInstructorToCourse
    @UserId INT,
    @CourseId INT,
    @Year INT


AS
BEGIN
    INSERT INTO CourseInstructor (UserId, CourseId, Year)
    VALUES (@UserId, @CourseId, @Year);
END;
GO

-- Update Course Details
Go
CREATE or Alter PROCEDURE UpdateCourseDetails
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


-- Delete Course
Go
CREATE or Alter PROC DeleteCourse
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

-- Delete Exam
GO
CREATE or Alter PROCEDURE DeleteExam
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

-- SearchCoursesByNameOrDescription 
Go
CREATE or ALTER VIEW SearchCoursesByNameOrDescription AS
SELECT 
    CourseName,
    CourseDescription,
    CourseMaxDegree,
    CourseMinDegree
FROM 
    Course;
GO


-- SearchUsersByRoleOrDepartment
GO
Create or Alter VIEW SearchUsersByRoleOrDepartment AS
SELECT 
    [User Full Name] = u.FirstName + ' ' + u.LastName,
    u.Email,
    u.Role,
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

-- SearchExamsByTypeOrDate
Go
CREATE OR Alter VIEW SearchExamsByTypeOrDate AS
SELECT 
    e.ExamType,
    e.StartTime,
    e.EndTime,
    i.IntakeName
FROM 
    Exam e
JOIN 
    Intake i ON e.IntakeId = i.IntakeId
JOIN 
    CourseInstructor ci ON e.CourseInstructorId = ci.CourseInstructorId;
GO


------------------------------------ Triggers  -----------------------------------------------------------------------


--This trigger will ensure that any new course inserted has valid Min_Degree and Max_Degree values.
Go
CREATE TRIGGER trg_CheckCourseDegree
ON Course
for INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted 
         WHERE CourseMinDegree <50 OR CourseMaxDegree < CourseMinDegree
    )
    BEGIN
        RAISERROR ('Min_Degree should be greater than or equal to 50 and less than or equal to Max_Degree.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
--This trigger will ensure that the email for a new instructor or in update existance instructor is unique.
Go
CREATE or Alter TRIGGER trg_CheckInstructorEmail
ON [dbo].[User]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN [dbo].[User] ins ON i.Email = ins.Email AND i.UserId != ins.UserId
    )
    BEGIN
        RAISERROR ('Email must be unique.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
Go



--This trigger ensures that each instructor can teach one or more courses, and each course may be taught by one instructor per class.
GO
CREATE TRIGGER trg_AssignInstructorToCourse
ON CourseInstructor
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN [dbo].[User] ins ON i.UserId = ins.UserId and ins.Type = 'Instructor'
        JOIN [dbo].[Course] c ON i.CourseId = c.CourseId
        WHERE NOT EXISTS (SELECT 1 FROM [dbo].[User] WHERE UserId = i.UserId)
           OR NOT EXISTS (SELECT 1 FROM Course WHERE CourseId = i.CourseId)
    )
    BEGIN
        RAISERROR ('Instructor or Course does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
Go