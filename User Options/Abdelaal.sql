
-- Create new exam 
CREATE PROCEDURE CreateExam
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

-- Add questions to exam
CREATE PROCEDURE AddQuestionsToExam
    @ExamId INT,
    @QuestionId INT,
    @QuestionDegree INT

as
BEGIN
    INSERT INTO ExamQuestion (ExamId, QuestionId, QuestionDegree)
    VALUES (@ExamId, @QuestionId, @QuestionDegree);
END;
GO


-- record student answer
CREATE PROCEDURE RecordStudentAnswers
    @StudentAssignedExamId INT,
    @ExamQuestionId INT,
    @StudentAnswerContent TEXT
 
as
BEGIN
    INSERT INTO StudentAnswer (StudentAssignedExamId, ExamQuestionId, StudentAnswerContent)
    VALUES (@StudentAssignedExamId, @ExamQuestionId, @StudentAnswerContent);
END;
GO

-- Update exam details`
Create PROCEDURE UpdateExamDetails
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


-- Register new user
Create PROCEDURE RegisterUser
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


-- Authenricate user
CREATE FUNCTION AuthenticateUser
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


-- Update user Information
CREATE PROCEDURE UpdateUserInfo
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

-- Delete users 
CREATE PROCEDURE DeleteUser
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



