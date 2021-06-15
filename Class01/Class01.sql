create table dbo.Student (
	Id int identity (1,1) NOT NULL,
	FirstName nvarchar (50) NOT NULL,
	LastName nvarchar (50) NOT NULL,
	DateOfBirth date NOT NULL,
	EnrolledDate date NOT NULL,
	Gender nvarchar (1) NOT NULL,
	NationalIdNumber bigint NOT NULL,
	StudentCardNumber bigint NOT NULL,
		constraint [PK_Student] primary key
		clustered (
			[Id] asc
		)
)
create table dbo.Teacher (
	Id int identity (1,1) NOT NULL,
	FirstName nvarchar (50) NOT NULL,
	LastName nvarchar (50) NOT NULL,
	DateOfBirth date NOT NULL,
	AcademicRank nvarchar(50) NOT NULL,
	HireDate date  NOT NULL,
		constraint [PK_Teacher] primary key
		clustered (
			[Id] asc
		)
)
create table dbo.Grade (
	Id int identity (1,1) NOT NULL,
	StudentID int NOT NULL,
	CourseID int NOT NULL,
	TeacherID int NOT NULL,
	Grade int NULL,
	Comment nvarchar(100)  NOT NULL,
		constraint [PK_Grade] primary key
		clustered (
			[Id] asc
		)
)
create table dbo.Course (
	Id int identity (1,1) NOT NULL,
	Name nvarchar (50) NOT NULL,
	Creadit int NOT NULL,
	AcademicYear date NOT NULL,
	Semester int NOT NULL,
		constraint [PK_Course] primary key
		clustered (
			[Id] asc
		)
)

create table dbo.AchievmentType (
	Id int identity (1,1) NOT NULL,
	Name nvarchar (50) NOT NULL,
	Description nvarchar (100) NOT NULL,
	ParticipationRate int NOT NULL,
		constraint [PK_AchievmentType] primary key
		clustered(
			[Id] asc
		)
)
create table dbo.GradeDetails (
	Id int identity (1,1) NOT NULL,
	GradeID int NOT NULL,
	AchievmentTypeID int NOT NULL,
	AchievmentPoints int NOT NULL,
	AchievmentMaxPoints int NOT NULL,
	AchievmentDate date NOT NULL,
		constraint [PK_GradeDetails] primary key
		clustered(
			[Id]asc
		)
)