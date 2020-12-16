CREATE TABLE Users (
		id INT IDENTITY,
		firstName VARCHAR(50),
		lastName VARCHAR(50),
		password VARCHAR(50),
		gender bit,
		email VARCHAR(50),
		address VARCHAR(50),
		PRIMARY KEY (id)
)

CREATE TABLE Instructor(
	id INT,
	rating DECIMAL(2,1),
	PRIMARY KEY(id), 
	FOREIGN KEY(id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE

)

CREATE TABLE UserMobileNumber(
	id int,
	mobileNumber VARCHAR(50),
	PRIMARY KEY(id,mobileNumber),
	FOREIGN KEY(id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
	
)

SELECT * FROM
Users

CREATE TABLE Student(
	id INT,
	GPA DECIMAL(3,2)
	PRIMARY KEY(id),
	FOREIGN KEY(id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Admin(
	id INT,
	PRIMARY KEY(id),
	FOREIGN KEY(id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Course(
	id INT IDENTITY,
	creditHours INT,
	name VARCHAR(50),
	courseDescripton VARCHAR(200),
	price DECIMAL(6,2),
	content VARCHAR(20),
	adminId INT,
	instructorId INT,
	accepted BIT,
	PRIMARY KEY(id),
	FOREIGN KEY(adminId) REFERENCES Admin ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY(instructorId) REFERENCES Instructor ON DELETE NO ACTION ON UPDATE NO ACTION
)


CREATE TABLE Assignment(

	cid INT,
	number INT,
	type VARCHAR(10),
	fullGrade INT,
	weight DECIMAL(4,1),
	deadline DATETIME,
	content VARCHAR(50)

)
CREATE TABLE feedback (
	cid INT,
	number INT,
	comments VARCHAR(240),
	numberOfLikes INT,
	sid INT,
	PRIMARY KEY(cid,number),
	FOREIGN KEY(cid) REFERENCES Course,
	FOREIGN KEY(sid) REFERENCES Student
);

SELECT* FROM
feedback

CREATE TABLE Promocode(
	code VARCHAR(20),
	issueDate datetime,
	expiryDate datetime,
	discountAmount INT,
	adminId INT,
	PRIMARY KEY(code),
	FOREIGN KEY(adminId) REFERENCES Admin
);

CREATE TABLE StudentHasPromocode (
	sid INT,
	code VARCHAR(20),
	FOREIGN KEY(sid) REFERENCES Student,
	FOREIGN KEY(code) REFERENCES Promocode
);

CREATE TABLE CreditCard (
	number int,
	cardHolderName VARCHAR(50),
	expiryDate datetime,
	cvv int,
	PRIMARY KEY(number)
);

CREATE TABLE StudentAddCreditCard (
	sid int,
	creditCardNumber int,
	FOREIGN KEY(sid) REFERENCES Student,
	FOREIGN KEY(creditCardNumber) REFERENCES CreditCard
);

CREATE TABLE StudentTakeCourse (
	sid int,
	cid int,
	instId int,
	payedfor bit,
	grade int,
	PRIMARY KEY(sid,cid,instId),
	FOREIGN KEY(sid) REFERENCES Student,
	FOREIGN KEY(cid) REFERENCES Course,
	FOREIGN KEY(instId) REFERENCES Instructor
);

CREATE TABLE StudentTakeAssignment (
	sid int,
	cid int,
	assignmentNumber int,
	assignmentType VARCHAR(200),
	grade int,
	PRIMARY KEY(sid, cid, assignmentNumber, assignmentType, grade),
	FOREIGN KEY(sid) REFERENCES Student,
	FOREIGN KEY(cid) REFERENCES Course,
	FOREIGN KEY(assignmentNumber) REFERENCES Assignment,
	FOREIGN KEY(assignmentType) REFERENCES Assignment
);

CREATE TABLE StudentRateInstructor (
	sid int,
	instId int,
	rate decimal (2,1),
	PRIMARY KEY(sid, instId),
	FOREIGN KEY (sid) references Student on delete NO ACTION on update NO ACTION,
	FOREIGN KEY (instId) references Instructor on delete NO ACTION on update NO ACTION
)

CREATE TABLE StudentCertifyCourse(
	sid int, 
	cid int,
	issueDate datetime,
	PRIMARY KEY(sid, cid),
	FOREIGN KEY(sid) references Student on delete NO ACTION on update NO ACTION,
	FOREIGN KEY(cid) references Course on delete NO ACTION on update NO ACTION
)

CREATE TABLE CoursePrerequisiteCourse(
	cid int,
	prerequisiteId int,
	PRIMARY KEY(cid, prerequisiteId),
	FOREIGN KEY(cid) references Course on delete NO ACTION on update NO ACTION,
	FOREIGN KEY(prerequisiteId) references Course on delete NO ACTION on update NO ACTION
)
CREATE TABLE InstructorTeachCourse(
	instId int,
	cid int,
	PRIMARY KEY(instId, cid),
	FOREIGN KEY(instId) references Instructor on delete NO ACTION on update NO ACTION,
	FOREIGN KEY(cid) references Course on delete NO ACTION on update NO ACTION
)



