/*
	Calculate the count of all grades in the system
	Calculate the count of all grades per Teacher in the system
	Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
	Find the Maximal Grade, and the Average Grade per Student on all grades in the system
*/
-- Part 1/3
select count(*) as Total
from dbo.Grade

select g.TeacherID ,count(*) as 'Total grades'
from dbo.Grade g
group by g.TeacherID

select g.TeacherID, count(*) as 'Total grades for first 100 students'
from dbo.Grade g
where g.StudentID <100
group by g.TeacherID

select MAX(Grade) as 'MAX', AVG(Grade) as 'AVG'
from dbo.Grade

/*
	Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
	Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
	Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system.
		-> Filter only records where Maximal Grade is equal to Average Grade
	List Student First Name and Last Name next to the other details from previous query
*/

-- Part 2/3
select count(*) as 'Count' , g.TeacherID as 'Teacher ID'
from dbo.Grade g
group by g.TeacherID
having(count(*) > 200)

select count(*) as 'Count', g.TeacherID as 'TeacherID'
from dbo.Grade g
where g.StudentID <= 100
group by g.TeacherID
having(count(Grade) > 50)

select concat(s.FirstName, ' ', s.LastName) as 'Full Name', count(*) as 'Grade count', max(g.Grade) as 'MAX', avg(g.Grade) as 'AVG'
from dbo.Grade g
inner join dbo.Student s on g.StudentID = s.Id
group by s.FirstName, s.LastName
having(max(g.grade)=avg(g.grade))

/*
	Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
	Change the view to show Student First and Last Names instead of StudentID
	List all rows from view ordered by biggest Grade Count
	Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
*/

create view vv_StudentGrades
as
select count(g.Grade) as 'Count', s.ID as 'Student ID'
from dbo.Student s
left join dbo.Grade g on g.StudentID = s.ID
group by s.ID

alter view vv_StudentGrades
as
select count(g.Grade) as 'Count', concat (FirstName, ' ', LastName) as 'FullName'
from dbo.Student s
inner join dbo.Grade g on g.StudentID =  s.ID
group by s.ID, concat(FirstName, ' ', LastName)

select *
from vv_StudentGrades
order by [Count] desc

--Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
create view vv_StudentGradeDetails
as
select concat(s.FirstName,' ', s.LastName) as 'Full Name', count(atype.Name) as 'Passed through exam count', atype.ID as 'Achievement ID'
from dbo.Student s
inner join dbo.Grade g on g.StudentID = s.ID
inner join dbo.GradeDetails gd on gd.GradeID = g.ID
inner join dbo.AchievementType atype on gd.AchievementTypeID = atype.ID
where atype.Name = 'Ispit' and g.Grade > 6 -- za proverka <6 ne vadi rezultati 
group by s.FirstName, s.LastName, atype.Name, atype.ID

select ID
from AchievementType
where Name = 'Ispit'

select *
from vv_StudentGradeDetails








