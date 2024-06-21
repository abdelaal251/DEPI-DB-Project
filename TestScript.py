import pyodbc
import pandas as pd

# Database connection details
server = '77.37.120.167,1433'
database = 'ExSys'

# User credentials
credentials = {
    'Admin': {'username': 'Admin1', 'password': 'P@ssw0rd'},
    'TrainingManager': {'username': 'TrainingManager1', 'password': 'P@ssw0rd'},
    'Instructor': {'username': 'Instructor1', 'password': 'P@ssw0rd'},
    'Student': {'username': 'Student1', 'password': 'P@ssw0rd'}
}

# Procedures and Functions to test
procedures_functions = [
    '[dbo].[AddNewBranch]',
    '[dbo].[AddNewCourse]',
    '[dbo].[AddNewIntake]',
    '[dbo].[AddNewTrack]',
    '[dbo].[AddQuestionsToExam]',
    '[dbo].[AssignInstructorToCourse]',
    '[dbo].[AssignStudentToExam]',
    '[dbo].[CreateExam]',
    '[dbo].[DeleteBranch]',
    '[dbo].[DeleteCourse]',
    '[dbo].[DeleteExam]',
    '[dbo].[DeleteStudent]',
    '[dbo].[DeleteUser]',
    '[dbo].[EditBranch]',
    '[dbo].[EditIntake]',
    '[dbo].[EditTrack]',
    '[dbo].[RecordStudentAnswers]',
    '[dbo].[RegisterStudent]',
    '[dbo].[RegisterUser]',
    '[dbo].[UpdateCourseDetails]',
    '[dbo].[UpdateExamDetails]',
    '[dbo].[UpdateStudentDetails]',
    '[dbo].[UpdateUserInfo]',
    '[dbo].[AuthenticateUser]'
]

# Log results
results = []

def test_procedure_function(cursor, name):
    try:
        if name == '[dbo].[AddNewBranch]':
            cursor.execute("{CALL dbo.AddNewBranch('Software Engineering', 1)}")
        elif name == '[dbo].[AddNewCourse]':
            cursor.execute("{CALL dbo.AddNewCourse('Math 101', 'Basic Math Course', 100, 60)}")
        elif name == '[dbo].[AddNewIntake]':
            cursor.execute("{CALL dbo.AddNewIntake('Fall 2024', '2024-09-01', '2024-12-31', 1)}")
        elif name == '[dbo].[AddNewTrack]':
            cursor.execute("{CALL dbo.AddNewTrack('Artificial Intelligence', 1)}")
        elif name == '[dbo].[AddQuestionsToExam]':
            cursor.execute("{CALL dbo.AddQuestionsToExam(1, 1, 10)}")
        elif name == '[dbo].[AssignInstructorToCourse]':
            cursor.execute("{CALL dbo.AssignInstructorToCourse(1, 1, 2024)}")
        elif name == '[dbo].[AssignStudentToExam]':
            cursor.execute("{CALL dbo.AssignStudentToExam(1, 1, '2024-06-15 10:00:00', '2024-06-15 12:00:00')}")
        elif name == '[dbo].[CreateExam]':
            cursor.execute("{CALL dbo.CreateExam('Final', '2024-06-15 10:00:00', '2024-06-15 12:00:00', 'Corrective', 1, 1)}")
        elif name == '[dbo].[DeleteBranch]':
            cursor.execute("{CALL dbo.DeleteBranch(1)}")
        elif name == '[dbo].[DeleteCourse]':
            cursor.execute("{CALL dbo.DeleteCourse(1)}")
        elif name == '[dbo].[DeleteExam]':
            cursor.execute("{CALL dbo.DeleteExam(1)}")
        elif name == '[dbo].[DeleteStudent]':
            cursor.execute("{CALL dbo.DeleteStudent(1)}")
        elif name == '[dbo].[DeleteUser]':
            cursor.execute("{CALL dbo.DeleteUser(1)}")
        elif name == '[dbo].[EditBranch]':
            cursor.execute("{CALL dbo.EditBranch(1, 'Network Engineering', 1)}")
        elif name == '[dbo].[EditIntake]':
            cursor.execute("{CALL dbo.EditIntake(1, 'Spring 2024', '2024-01-01', '2024-04-30', 1)}")
        elif name == '[dbo].[EditTrack]':
            cursor.execute("{CALL dbo.EditTrack(1, 'Cybersecurity', 1)}")
        elif name == '[dbo].[RecordStudentAnswers]':
            cursor.execute("{CALL dbo.RecordStudentAnswers(1, 1, 'Answer text')}")
        elif name == '[dbo].[RegisterStudent]':
            cursor.execute("{CALL dbo.RegisterStudent(1)}")
        elif name == '[dbo].[RegisterUser]':
            cursor.execute("{CALL dbo.RegisterUser('John', 'Doe', 'john.doe@example.com', 'Student', 'FullTime', 'password123')}")
        elif name == '[dbo].[UpdateCourseDetails]':
            cursor.execute("{CALL dbo.UpdateCourseDetails(1, 'Math 102', 'Intermediate Math Course', 100, 60)}")
        elif name == '[dbo].[UpdateExamDetails]':
            cursor.execute("{CALL dbo.UpdateExamDetails(1, 'Midterm', '2024-06-20 10:00:00', '2024-06-20 12:00:00', 'ClosedBook')}")
        elif name == '[dbo].[UpdateStudentDetails]':
            cursor.execute("{CALL dbo.UpdateStudentDetails(1, 'Updated Details')}")
        elif name == '[dbo].[UpdateUserInfo]':
            cursor.execute("{CALL dbo.UpdateUserInfo(1, 'John', 'Doe', 'john.doe@example.com', 'Student', 'PartTime')}")
        elif name == '[dbo].[AuthenticateUser]':
            cursor.execute("SELECT dbo.AuthenticateUser('john.doe@example.com', 'password123')")
        cursor.commit()
        return 'pass', ''
    except Exception as e:
        return 'fail', str(e)

# Test each procedure/function with each user
for proc_func in procedures_functions:
    row = {'Procedure / Function': proc_func}
    for user, creds in credentials.items():
        conn_str = f"DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={creds['username']};PWD={creds['password']}"
        try:
            with pyodbc.connect(conn_str) as conn:
                cursor = conn.cursor()
                result, reason = test_procedure_function(cursor, proc_func)
                row[f"{user}"] = result
                row[f"{user} Fail Reason"] = reason
        except Exception as e:
            row[f"{user}"] = 'fail'
            row[f"{user} Fail Reason"] = str(e)
    results.append(row)

# Create DataFrame and save to Excel
df = pd.DataFrame(results)
file_path = 'procedure_function_test_results.xlsx'
df.to_excel(file_path, index=False)
print(f"Results have been saved to {file_path}")