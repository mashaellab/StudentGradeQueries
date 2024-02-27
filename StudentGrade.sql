
/* Hello .. I'm MashaelAB,

I've created a Database with simple Tables and Random data,
Here are some basic queries I've executed after linking the tables together.

Thank you for your time, and I wish you all a beautiful day! */


/* --------- Simple Queries --------- */

--  1) Display Full Name of the Student (ALIASING STETMENT) 
	
	SELECT First_Name +' ' + Last_Name AS Student_Name 
	FROM StudentGrade.dbo.Student

--  2) Display All Course Name In DataBase 

	SELECT DISTINCT Course_Name AS Course_Name 
	FROM StudentGrade.dbo.Course

--  3) Display Student Gender And Count  

	SELECT Gender , COUNT(Gender) AS Students_Count
	FROM StudentGrade.dbo.Student
	GROUP BY Gender

-- 4) Update Student Table

	UPDATE StudentGrade.dbo.Student
	SET Phone_Number = '111-655-1111'
	WHERE Student_ID = 1


/* --------- JION TABLES --------- */	

-- Tow Table 
	SELECT  First_Name ,[Last_Name ],Gender,Student_Grade,Grade_Letter 
	FROM StudentGrade.dbo.Grade AS gr
	INNER JOIN  StudentGrade.dbo.Student AS st 
		ON st.Student_ID = gr.Student_id
	

-- Three Table
	SELECT First_Name ,[Last_Name ],Gender,Course_Name ,Student_Grade,Grade_Letter 
	FROM StudentGrade.dbo.Grade AS gr
	INNER JOIN  StudentGrade.dbo.Student AS st 
		ON st.Student_ID = gr.Student_id
	INNER JOIN  StudentGrade.dbo.Course AS cr
		ON gr.Course_ID = cr.Course_ID
	


/* --------- Queries --------- */


-- The Number of Students Enrolled in each Course Sorted in Descending Order 

	SELECT  Course_Name ,COUNT(Student_id) AS Students_Count
	FROM StudentGrade.dbo.Student AS st
	INNER JOIN StudentGrade.dbo.Course AS cr  
		ON st.Student_ID = cr.Course_ID
	GROUP BY Course_Name 
	ORDER BY Students_Count DESC

-- Avrage of Grade in each Course Sorted in Descending Order

	SELECT  Course_Name , AVG(Student_Grade)  AS Avrage_Grades ,
	MAX(Student_Grade)  AS Max_Grade , MIN(Student_Grade)  AS MIN_Grade
	FROM StudentGrade.dbo.Grade AS gr
	INNER JOIN StudentGrade.dbo.Course AS cr  
		ON gr.Grade_ID = cr.Course_ID
	GROUP BY Course_Name 
	ORDER BY Avrage_Grades DESC

--Names of Students Enrolled in more than one Course along with the Total Number of Units
--(HAVING STETMENT)

	SELECT First_Name ,[Last_Name ] , count(Course_Name) AS Courses_Count ,sum([Credit_Units ]) AS Sum_Units
	FROM StudentGrade.dbo.Grade AS gr
	INNER JOIN  StudentGrade.dbo.Student AS st 
		ON st.Student_ID = gr.Student_id
	INNER JOIN  StudentGrade.dbo.Course AS cr
		ON gr.Course_ID = cr.Course_ID
	GROUP BY Course_Name ,First_Name ,[Last_Name ],[Credit_Units ]
	HAVING COUNT(Course_Name) > 1

--Number of Students in Each Semester

	SELECT  Semester,COUNT(Student_ID) AS Students_Count 
	FROM StudentGrade.dbo.Student AS st
	INNER JOIN  StudentGrade.dbo.Course AS cr 
		ON st.Student_ID = cr.Course_ID
	GROUP BY Semester


/* ---- A query That Displays the Totle Number of Students in Each Course
        along with the Number of Students who Passed and Failed. (CASE STETMENT)--------- */


	SELECT Course_Name,count(st.Student_ID) AS Students_Count,		
		SUM(CASE WHEN Student_Grade >= 60 THEN 1 ELSE 0 END) AS Passed_Students,
		SUM(CASE WHEN Student_Grade < 60 THEN 1 ELSE 0 END) AS Failed_Students
	FROM StudentGrade.dbo.Grade AS gr
	INNER JOIN  StudentGrade.dbo.Student AS st 
		ON st.Student_ID = gr.Student_id
	INNER JOIN  StudentGrade.dbo.Course AS cr
		ON gr.Course_ID = cr.Course_ID
	GROUP BY Course_Name
	ORDER BY Failed_Students DESC --which course has the most failures

-- Course_Grade (CASE STETMENT)

	SELECT First_Name,[Last_Name ],Student_Grade,	Grade_Letter,	
		CASE
		WHEN Grade_Letter = 'A' THEN 'Excellent' 
		WHEN Grade_Letter = 'B' THEN 'Very Good'
		WHEN Grade_Letter = 'C' THEN 'Good'
		WHEN Grade_Letter = 'D' THEN 'Passing'
		ELSE 'Failed'
		END AS Course_Grade
	FROM StudentGrade.dbo.Grade AS gr
	INNER JOIN  StudentGrade.dbo.Student AS st 
		ON st.Student_ID = gr.Student_id
	
