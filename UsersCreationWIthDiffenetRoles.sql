-- Create the login user for the instance
CREATE LOGIN Admin1 WITH PASSWORD = 'P@ssw0rd';
CREATE LOGIN TrainingManager1 WITH PASSWORD = 'P@ssw0rd';
CREATE LOGIN Instructor1 WITH PASSWORD = 'P@ssw0rd';
CREATE LOGIN Student1 WITH PASSWORD = 'P@ssw0rd';

-- Create a database users
USE ExSysTest;
CREATE USER Admin1 FOR LOGIN Admin1;
CREATE USER TrainingManager1 FOR LOGIN TrainingManager1;
CREATE USER Instructor1 FOR LOGIN Instructor1;
CREATE USER Student1 FOR LOGIN Student1;



GRANT EXECUTE ON OBJECT::RegisterUser TO Admin1;
GRANT EXECUTE ON OBJECT::AuthenticateUser TO Admin1;
GRANT EXECUTE ON OBJECT::UpdateUserInfo TO Admin1;
GRANT EXECUTE ON OBJECT::DeleteUser TO Admin1;
GRANT EXECUTE ON OBJECT::AddNewCourse TO Admin1;
GRANT EXECUTE ON OBJECT::AssignInstructorToCourse TO Admin1;
GRANT EXECUTE ON OBJECT::UpdateCourseDetails TO Admin1;
GRANT EXECUTE ON OBJECT::DeleteCourse TO Admin1;
GRANT EXECUTE ON OBJECT::CreateExam TO Admin1;
GRANT EXECUTE ON OBJECT::AddQuestionsToExam TO Admin1;
GRANT EXECUTE ON OBJECT::RecordStudentAnswers TO Admin1;
GRANT EXECUTE ON OBJECT::UpdateExamDetails TO Admin1;
GRANT EXECUTE ON OBJECT::DeleteExam TO Admin1;

exec RegisterUser 