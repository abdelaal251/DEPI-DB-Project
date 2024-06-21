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
