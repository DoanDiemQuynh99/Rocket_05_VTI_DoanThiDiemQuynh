DROP DATABASE QUANLY;
CREATE  DATABASE QUANLY;
use QUANLY;

DROP TABLE Department;

CREATE TABLE  Department (
DepartmentID INT PRIMARY KEY NOT NULL,
DepartmentName VARCHAR (10)
);
INSERT INTO Department (`DepartmentID`,`DepartmentName`) VALUES ('1','VTT'),('2','VTA'),('3','VTB'),('4','VTC'),('5','VTD'),('6','VTF'),('7','VTG'),('8','VTH'),('9','VTJ'),('10','VTK');


CREATE TABLE  Position (
PositionID INT PRIMARY KEY NOT NULL,
PositionName VARCHAR(50)
);
INSERT INTO Position (`PositionID`, `PositionName`) VALUES ();

CREATE TABLE  `Account` (
AccountID INT PRIMARY KEY NOT NULL,
Email VARCHAR(100) NOT NULL,
Username VARCHAR(50) NOT NULL,
FullName VARCHAR(50) NOT NULL,
DepartmentID INT NOT NULL,
PositionID INT NOT NULL,
CreateDate DATETIME  NOT NULL,
FOREIGN KEY (PositionID) REFERENCES Positition (PositionID)
);

INSERT INTO `Account`(`AccountID`, `Email`, `Username`, `FullName`, `DepartmentID', 'PositionID`, `CreateDate`) VALUES();


DROP TABLE `GROUP`; 
CREATE TABLE `GROUP` (
GroupID INT PRIMARY KEY NOT NULL,
GroupName VARCHAR(100) NOT NULL,
CreatorID INT NOT NULL, 
CreateDate DATETIME DEFAULT NOW()
);

INSERT INTO `GROUP`(GroupID,GroupName,CreatorID) VALUES (1, 'ROCKET05', 1);
SELECT * FROM `GROUP`;
 
DROP TABLE GroupAccount;
CREATE TABLE GroupAccount(
GroupID INT NOT NULL,
AccountID INT NOT NULL,
JoinDate DATETIME NOT NULL,
FOREIGN KEY(GroupID) REFERENCES `GROUP`(GroupID)
);
INSERT INTO GroupAccount (GroupID, AccountID, JoinDate) VALUES ();

CREATE TABLE TypeQuestion(
TypeID INT PRIMARY KEY NOT NULL,
TypeName VARCHAR(100)
);
INSERT INTO TypeQuestion(TypeID, TypeName) VALUES ();

CREATE TABLE CategoryQuestion(
CategoryID INT PRIMARY KEY NOT NULL,
CategoryName VARCHAR(100)
);
INSERT INTO CategoryQuestion(CategoryID, CategoryName) VALUES ();


CREATE TABLE Question(
QuestionID INT NOT NULL,
Content TEXT NULL,
CategoryID INT NOT NULL,
TypeID  INT NOT NULL,
CreatorID INT NOT NULL,
CreateDate DATETIME NOT NULL,
FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID)
);
INSERT INTO Question(QuestionID, Content, CategoryID, TypeID,CreateID, CreateDate) VALUES();


CREATE TABLE  Answer(
AnswerID INT NOT NULL,
Content TEXT NULL,
QuestionID INT NOT NULL,
isCorrect BOOLEAN NOT NULL
);
INSERT INTO Answer (AnswerID, Content, QuestionID, isCorrect) VALUES();


CREATE TABLE Exam(
ExamID INT NOT NULL,
`Code` VARCHAR(10),
Title TEXT NOT NULL,
CategoryID INT NOT NULL,
Duration TIME NOT NULL,
CreatorID INT NOT NULL,
CreateDate DATETIME NOT NULL,
FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID)
);
INSERT INTO Exam (ExamID, `Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ();



CREATE TABLE ExamQuestion(
ExamID INT NOT NULL,
QuestionID INT NOT NULL
);
INSERT INTO ExamQuestion(ExamID, QuestionID) VALUES();


CREATE TABLE TEST(
CHIEUCAO DECIMAL(5,2)
);
INSERT  INTO TEST  VALUES (12.098);
SELECT * FROM  TEST;

ALTER TABLE TEST ADD CANNANG FLOAT AFTER CHIEUCAO;
SHOW COLUMNS FROM TEST;

CREATE TABLE NumberEnd(
 ten1 VARCHAR (10),
 TEN2 CHAR (10)
 );
 
 INSERT INTO  NumberEnd  VALUES ('QUYNH', 'DOAN DIEM');
 SELECT * FROM NumberEnd;

