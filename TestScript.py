import pyodbc
import pandas as pd

# Database connection details
server = '77.37.120.167,1433'
database = 'ExSysTest'

# User credentials
credentials = {
    'Admin': {'username': 'Admin1', 'password': 'P@ssw0rd'},
    'TrainingManager': {'username': 'TrainingManager1', 'password': 'P@ssw0rd'},
    'Instructor': {'username': 'Instructor1', 'password': 'P@ssw0rd'},
    'Student': {'username': 'Student1', 'password': 'P@ssw0rd'}
}

# Procedures and Functions to test
procedures_functions = [
    'RegisterUser',
    'AuthenticateUser',
    'UpdateUserInfo',
    'DeleteUser',
    'AddNewCourse',
    'AssignInstructorToCourse',
    'UpdateCourseDetails',
    'DeleteCourse',
    'CreateExam',
    'AddQuestionsToExam',
    'RecordStudentAnswers',
    'UpdateExamDetails',
    'DeleteExam'
]

# Log results
results = []

def test_procedure_function(cursor, name):
    try:
        if name == 'RegisterUser':
            cursor.execute("{CALL RegisterUser('John', 'Doe', 'john.doe@example.com', 'Student', 'password123')}")
        elif name == 'AuthenticateUser':
            cursor.execute("SELECT dbo.AuthenticateUser('john.doe@example.com', 'password123')")
        elif name == 'UpdateUserInfo':
            cursor.execute("{CALL UpdateUserInfo(1, 'John', 'Doe', 'john.doe@example.com', 'Student', 'PartTime')}")
        elif name == 'DeleteUser':
            cursor.execute("{CALL DeleteUser(1)}")
        elif name == 'AddNewCourse':
            cursor.execute("{CALL AddNewCourse('Math 101', 'Basic Math Course', 100, 60)}")
        elif name == 'AssignInstructorToCourse':
            cursor.execute("{CALL AssignInstructorToCourse(1, 1, 2024)}")
        elif name == 'UpdateCourseDetails':
            cursor.execute("{CALL UpdateCourseDetails(1, 'Math 102', 'Intermediate Math Course', 100, 60)}")
        elif name == 'DeleteCourse':
            cursor.execute("{CALL DeleteCourse(1)}")
        elif name == 'CreateExam':
            cursor.execute("{CALL CreateExam('Final', '2024-06-15 10:00:00', '2024-06-15 12:00:00', 'OpenBook', 1, 1)}")
        elif name == 'AddQuestionsToExam':
            cursor.execute("{CALL AddQuestionsToExam(1, 1, 10)}")
        elif name == 'RecordStudentAnswers':
            cursor.execute("{CALL RecordStudentAnswers(1, 1, 'Answer text')}")
        elif name == 'UpdateExamDetails':
            cursor.execute("{CALL UpdateExamDetails(1, 'Midterm', '2024-06-20 10:00:00', '2024-06-20 12:00:00', 'ClosedBook')}")
        elif name == 'DeleteExam':
            cursor.execute("{CALL DeleteExam(1)}")
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