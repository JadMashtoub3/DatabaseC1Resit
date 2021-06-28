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

