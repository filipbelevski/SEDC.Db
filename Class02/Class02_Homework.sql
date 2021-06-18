/*
Find all Students with FirstName= Antonio
Find all Students with DateOfBirthgreater than ‘01.01.1999’
Find all Male students Find all Students with LastNamestarting With ‘T’
Find all Students Enrolled in January/1998
Find all Students with LastNamestarting With ‘J’ enrolled in January/1998
*/

-- PART 1/6
select *
from dbo.Student
where FirstName = 'Antonio'

select *
from dbo.Student
where DateOfBirth > '01.01.1999'

select *
from dbo.Student
where LastName like 'T%'

select *
from dbo.Student
where EnrolledDate >= '01.01.1998' and EnrolledDate <= '01.31.1998'

select *
from dbo.Student
where LastName like 'J%' and EnrolledDate >= '01.01.1998' and EnrolledDate <= '01.31.1998'

/*
	Find all Students with FirstName= Antonio ordered by Last Name
	List all Students ordered by FirstName
	Find all Male students ordered by EnrolledDate, starting from the last enrolled
*/
--Part 2/6
select *
from dbo.Student
where FirstName = 'Antonio'
order by LastName asc

select*
from dbo.Student
order by FirstName asc

select *
from dbo.Student
where Gender = 'M'
order by EnrolledDate desc


/*
List all Teacher First Names and Student First Names in single result set with duplicates
List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
List all common First Names for Teachers and Students
*/
--Part 3/6
select FirstName
from dbo.Student
union all
select FirstName
from dbo.Teacher

select LastName
from dbo.Student
union
select LastName
from dbo.Teacher

select FirstName
from dbo.Student
intersect
select FirstName
from dbo.Teacher

/*
	Change GradeDetailstable always to insert value 100 in AchievementMaxPointscolumn if no value is provided on insert
	Change GradeDetailstable to prevent inserting AchievementPointsthat will more than AchievementMaxPoints
	Change AchievementTypetable to guarantee unique names across the Achievement types
*/
--Part 4/6
alter table dbo.GradeDetails
add constraint DF_GradeDetails_AchievmentMaxPoints
default 100 for [AchievementMaxpoints]

alter table dbo.GradeDetails
add constraint CHK_GradeDetails_AchievementPoints
check (AchievementPoints <= AchievementMaxPoints)

alter table dbo.AchievementType
add constraint UC_AchievementType_Name unique (Name)

--Create Foreign key constraints from diagram or with script
--Part 5/6
--ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order]([Id]);
alter table dbo.[Grade] add constraint [FK_Grade_Student] foreign key (StudentID) references dbo.Student(Id)
alter table dbo.Grade add constraint [FK_Grade_Course] foreign key (CourseID) references dbo.Course(Id)
alter table dbo.Grade add constraint [FK_Grade_Teacher] foreign key (TeacherID) references dbo.Teacher(Id)
alter table dbo.GradeDetails add constraint [FK_GradeDetails_AchievementTypeID] foreign key (AchievementTypeID) references dbo.AchievementType(Id)
alter table dbo.GradeDetails add constraint [FK_GradeDetails_Grade] foreign key (GradeID) references dbo.Grade(ID)


/*
List all possible combinations of Courses names and AchievementTypenames that can be passed by student  ??????
List all Teachers that has any exam Grade 
List all Teachers without exam Grade
List all Students without exam Grade (using Right Join)
*/
--Part 6/6

select Name as 'Can be passed by student'
from dbo.Course
union all 
select Name
from dbo.AchievementType

select concat(FirstName,N' ', Lastname) as 'Teachers with no grades'
from dbo.Teacher t
left join dbo.Grade gd on gd.TeacherId= t.ID
where gd.Grade is null

select concat(FirstName,' ', LastName) as 'Teachers with any grades'
from dbo.Teacher t
left join dbo.Grade gd on gd.TeacherId= t.ID
where gd.Grade is not null
union
select concat(FirstName,' ', LastName)
from dbo.Teacher
order by concat(FirstName,' ', LastName)

select concat (FirstName,' ', LastName) as 'Students '
from dbo.Grade g
right join dbo.Student as s on g.StudentID = s.Id
where g.Id is null

