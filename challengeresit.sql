/*Jad Mashtoub 103596586

Subject(SubjCode, Description)
PK(SubjCode)

Student(StudentID, Surname, GivenName, Gender)
PK(StudentID)

SubjectOffering(SubjCode, Year, Semester, Fee, StaffID)
CompPK(SubjCode, Year, Semester)
FK(StaffID) REF Teacher
FK(SubjCode)REF subject

Enrolment(StudentId, SubjCode, Year, Semester, Grade, DateEnrolled)
CompPK(StudentId, SubjCode, Year, Semester)
FK(StudentID) REF Student
CompFK(SubjCode, Year, Semester) REF SubjectOffering

Teacher(StaffID, Surname, GivenName)
PK(StaffID)
*/
-- Create a new database called 'ChallengeResit'
-- Connect to the 'master' database to run this snippet
USE ChallengeResit1
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'ChallengeResit1
    '
)
CREATE DATABASE ChallengeResit1
GO

IF OBJECT_ID('SubjectOffering', 'U') IS NOT NULL
DROP TABLE SubjectOffering
GO

IF OBJECT_ID('Subject', 'U') IS NOT NULL
DROP TABLE Subject
GO

IF OBJECT_ID('Student', 'U') IS NOT NULL
DROP TABLE Student
GO

IF OBJECT_ID('Enrolment', 'U') IS NOT NULL
DROP TABLE Enrolment
GO

IF OBJECT_ID('Teacher', 'U') IS NOT NULL
DROP TABLE Teacher
GO

CREATE TABLE Subject
(
    SubjCode [NVARCHAR](100) PRIMARY KEY,
    Description [NVARCHAR](50) NOT NULL
  
);




CREATE TABLE Student
(
    StudentId [NVARCHAR](10) PRIMARY KEY,
    Surname [NVARCHAR](100) NOT NULL,
    GivenName [NVARCHAR](100) NOT NULL,
    Gender [NVARCHAR] (1)
    Constraint check_gender Check (Gender IN ('M', 'F', 'i'))
);



CREATE TABLE SubjectOffering
(
    SubjCode [NVARCHAR](100) , 
    FOREIGN KEY (SubjCode) REFERENCES Subject,
    Year INT,
    Semester INT,
    Fee Money NOT NULL,
    StaffID INT
    FOREIGN KEY (StaffID) REFERENCES Teacher,
    Primary KEY(SubjCode, Year, Semester),
    CONSTRAINT check_year
        CHECK (DATALENGTH(Year) = 4),
    CONSTRAINT check_Semester CHECK (Semester IN('1','2')),
    CONSTRAINT check_Fee
        CHECK(Fee > 0)
);




CREATE TABLE Enrolment
(
    StudentId [NVARCHAR](10),
    FOREIGN KEY (StudentID) REFERENCES Student,
    SubjCode [NVARCHAR](100),
    Year INT,
    Semester INT,
    Grade [NVARCHAR](2),
    DateEnrolled DATE
    PRIMARY KEY(StudentId, SubjCode, Year, Semester),
    CONSTRAINT FK_StudentID FOREIGN KEY (SubjCode, Year, Semester)
        REFERENCES SubjectOffering(SubjCode, Year, Semester),
    CONSTRAINT check_Grade Check (Grade IN('N', 'P','C','D','HD'))
);



CREATE TABLE Teacher
(
    StaffID INT PRIMARY KEY,
    Surname [NVARCHAR](100) NOT NULL,
    GivenName [NVARCHAR](100) NOT NULL,
   Constraint check_StaffID CHECK (LEN(StaffID)=8)
);

Insert INTO Subject (SubjCode, [Description])
            Values ('ICTPRG418', 'Apply SQL to extract & manipulate data'),
                   ('ICTBSB430',	'Create Basic Databases'),
                    ('ICTDBS205',	'Design a Database')

INSERT INTO Teacher (StaffID, Surname, GivenName)
            Values (98776655, 'Young', 'Angus'),
                    (87665544, 'Scott', 'Bon'),
                    (76554433, 'Slade', 'Chris')
INSERT INTO  Enrolment(StudentId, SubjCode, [Year], Semester, Grade, DateEnrolled)
                Values('s12233445', 'ICTPRG418', 2019, '1', 'D', '02/25/2019'),
                      ('s23344556', 'ICTPRG418', 2019, '1', 'C', '02/15/2020'),
                      ('s12233445', 'ICTPRG418', 2020, '1', 'C', '01/30/2021'),
                      ('s23344556', 'ICTPRG418', 2020, '1', 'HD', '02/26/2020'),
                      ('s34455667', 'ICTPRG418', 2020, '1', 'P', '01/28/2020'),
                      ('s12233445', 'ICTBSB430', 2020, '1', 'C', '02/08/2020'),
                      ('s23344556', 'ICTBSB430', 2020, '2', 'N','06/30/2020'),
                      ('s34455667', 'ICTBSB430', 2020, '2', 'N','07/03/2020'),
                      ('s23344556', 'ICTDBS205', 2019, '2', 'P', '07/01/2019'),
                      ('s34455667', 'ICTDBS205', 2019, '2', 'N', '07/13/2019')
INSERT INTO SubjectOffering (SubjCode, Year, Semester, Fee, StaffID)
                VALUES      ('ICTPRG418', 2019, '1', '200', '98776655'),
                            ('ICTPRG418', 2020, '1', '225', '98776655'),
                            ('ICTBSB430', 2020, '1', '200', '87665544'),
                            ('ICTBSB430', 2020, '2', '200', '76554433'),
                            ('ICTDBS205', 2019, '2', '225', '87665544')

INSERT INTO Student(StudentId, Surname, GivenName, Gender)
            Values('s12233445', 'Baird', 'Tim', 'M'),
                   ('s23344556', 'Nguyen', 'Anh', 'M'),
                   ('s34455667', 'Hallinan,', 'James', 'M')

GO
Select * FROM Student

Select * FROM Subject

Select * From SubjectOffering

Select * FROM Enrolment

Select * FROM Teacher
GO

/*query one */
Select Student.GivenName, Student.Surname, Subject.SubjCode, subject.[Description], SubjectOffering.[Year], Subjectoffering.Semester, SubjectOffering.Fee, Teacher.GivenName, Teacher.Surname
From Student, Subject, SubjectOffering, Teacher

/*query two */
Select SubjectOffering.[Year], SubjectOffering.Semester,  count(*) "Enrolments"
from SubjectOffering
Group by SubjectOffering.[Year], SubjectOffering.Semester
/* query three */
Select *
from Enrolment
Order by Enrolment.DateEnrolled DESC;

/*View Based */
CREATE VIEW [Task5] AS
Select Student.GivenName, Student.Surname, Subject.SubjCode, subject.[Description], SubjectOffering.[Year], Subjectoffering.Semester, SubjectOffering.Fee, Teacher.GivenName AS TeacherName , Teacher.Surname AS TeacherSurName
From Student, Subject, SubjectOffering, Teacher


Select count(*) from Student
Select * from student
/*This is showing the correct number of columns in the student table */
Select count(*) from Teacher
Select * from Teacher
/*This is showing the correct number of columns in the Teacher table*/
Select count(*) from subject
Select * from Subject
/*This is showing the correct number of columns in the subject table */
select count(*) from subjectoffering
Select * from subjectoffering
/*This is showing the correct number of columns in the subjectoffering table */
select count(*) from Enrolment
select * from Enrolment
/*This is showing the correct number of columns in the Enrolment table */