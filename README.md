# DEPI Examination System Database project

### Overview
The ExSys database manages students, instructors, departments, branches, courses, exams, and related data. Key entities include User, Student, Department, Branch, Track, Intake, Course, Question, Instructor, CourseInstructor, Exam, ExamQuestion, StudentAssignedExam, and StudentAnswer.

### Files Included
- `DEPI ER Diagram.pdf`: Visual representation of the ER diagram.
- `DEPI ER Diagram Data Model.pdf`: Detailed data model with entities, attributes, and relationships.
- `DEPI ER Diagram(Native).drawio`: Native draw.io file used to generate the diagrams

### Usage
The ExSys database system is designed to handle various academic and administrative tasks:

1. **User Management**:
   - **RegisterUser**: Registers new users (students, instructors, admins).
   - **AuthenticateUser**: Authenticates users for login.
   - **UpdateUserInfo**: Updates user information.
   - **DeleteUser**: Deletes a user from the system.

2. **Course Management**:
   - **AddNewCourse**: Adds new courses to the system.
   - **AssignInstructorToCourse**: Assigns instructors to courses.
   - **UpdateCourseDetails**: Updates course details.
   - **DeleteCourse**: Deletes a course from the system.

3. **Exam Management**:
   - **CreateExam**: Creates a new exam.
   - **AddQuestionsToExam**: Adds questions to an exam.
   - **UpdateExamDetails**: Updates exam details.
   - **DeleteExam**: Deletes an exam.
   - **RecordStudentAnswers**: Records student answers for exams.

4. **Department, Branch, and Track Management**:
   - **AddNewBranch**: Adds a new branch.
   - **EditBranch**: Edits details of a branch.
   - **AddNewTrack**: Adds a new track.
   - **EditTrack**: Edits details of a track.
   - **AddNewIntake**: Adds a new intake period.
   - **EditIntake**: Edits details of an intake period.

5. **Student Management**:
   - **RegisterStudent**: Registers a student for an intake.
   - **UpdateStudentDetails**: Updates student details.
   - **AssignStudentToExam**: Assigns students to exams.

### Deliverables
- [ER Diagram PDF](DEPI-DB-Project/TestScript.py)
- [Data Model PDF](files/DEPI_ER_Diagram_Data_Model.pdf)
- [Draw.io Native File](files/DEPI_ER_Diagram(Native).drawio)
- [Script File](files/test_queries.sql)
- [Python Test Script](files/python_test_script.py)
- [CSV File](files/user_permissions.csv)
- [Excel Test Results](files/procedure_function_test_results.xlsx)

### How to Add File Paths for Downloads
1. **Locate the File**: Ensure the file is in your repository or server.
2. **Copy the Path**: Copy the relative path from your repository root to the file.
3. **Add to Markdown**: Use the `[description](path/to/file)` format to create a link.

### Testing
The overall testing technique involved using Python to automate the testing of all stored procedures and functions within the ExSys database. The Python script executed each procedure/function and logged the results, indicating success or failure for each user role.

**Testing Steps**:
1. **Setup**: Establish a connection to the ExSys database.
2. **Execution**: Run each stored procedure/function using predefined inputs.
3. **Validation**: Compare the output or database state against expected results.
4. **Logging**: Record the outcome of each test case in an Excel file.

The testing script `python_test_script.py` utilized the pyodbc library to connect to the SQL Server database and pandas for handling the test results.

### Script Generation
We used a Python script to generate SQL queries that grant or deny specific users access to particular procedures or functions based on a CSV file.

**Script Steps**:
1. **Read CSV**: Load the user permissions from the CSV file.
2. **Generate SQL**: Create SQL statements to grant or deny permissions according to the CSV data.
3. **Execute SQL**: Run the generated SQL statements to apply the permissions in the ExSys database.
A sample from the CSV source can be found below

| Procedure      | Admin1 | TrainingManager1 | Instructor1 | Student1 |
|----------------|--------|------------------|-------------|----------|
| RegisterUser   | GRANT  | DENY             | DENY        | DENY     |


The script ensures that each user's access is correctly configured based on their role and the defined permissions in the CSV file.

For further details or modifications, please update the README file.

## Team Members
- Noha Gamal Salah
- Ahmed Mohamed Ahmed Abdelaal
- Ahmed Mohamed Maher
