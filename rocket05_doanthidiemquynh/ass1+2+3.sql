drop database quanly;
create database quanly;
use quanly;
-- ass 1+2
DROP TABLE department;

CREATE TABLE department(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR (20)
);

CREATE TABLE  `Position` (
PositionID INT PRIMARY KEY NOT NULL,
PositionName VARCHAR(50)
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
AccountID INT PRIMARY KEY,
Email VARCHAR(50) NOT NULL UNIQUE KEY,
Username VARCHAR(50) NOT NULL UNIQUE KEY,
FullName VARCHAR(50) NOT NULL,
DepartmentID INT NOT NULL,
PositionID	INT NOT NULL,
CreateDate	DATETIME DEFAULT NOW(),
FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
GroupID	INT PRIMARY KEY,
GroupName NVARCHAR(50) NOT NULL,
CreatorID INT NOT NULL UNIQUE KEY,
CreateDate	DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
GroupAccountID	INT PRIMARY KEY,			
GroupID	INT NOT NULL,
AccountID INT NOT NULL,
JoinDate DATETIME DEFAULT NOW(),
FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID),
FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
TypeID INT  PRIMARY KEY,
TypeName ENUM('Essay','Multiple-Choice') NOT NULL
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
CategoryID	INT PRIMARY KEY,
CategoryName NVARCHAR(50) NOT NULL UNIQUE
);


DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
QuestionID INT PRIMARY KEY,
Content TEXT NULL,
CategoryID INT NOT NULL,
TypeID  INT NOT NULL,
CreatorID INT NOT NULL,
CreateDate DATETIME NOT NULL,
FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
AnswerID INT PRIMARY KEY,
Content	NVARCHAR(50) NOT NULL,
QuestionID INT NOT NULL,
isCorrect BOOLEAN NOT NULL,
FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);


CREATE TABLE Exam(
ExamID INT NOT NULL,
`Code` VARCHAR(10),
Title TEXT NOT NULL,
CategoryID INT NOT NULL,
Duration INT NOT NULL,
CreatorID INT NOT NULL,
CreateDate DATETIME NOT NULL,
FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
ExamID	INT NOT NULL,
QuestionID	INT NOT NULL,
PRIMARY KEY(ExamID,QuestionID)
);


-- ass3 
-- insert du lieu
INSERT INTO Department
                  (DepartmentID,     DepartmentName) 
VALUE 
					('1',            'Marketing'),
					('2',           'Sale'),
					('3' ,             'Bảo vệ'),
						('4', 'Nhânsự'		),
						('5', 'Kỹthuật'	),
						('6', 'Tàichính'	),
						('7', 'Pgiámđốc'),
						('8', 'Giámđốc'	),
						('9', 'Thưkí'		),
						('10', 'Bánhàng'	);

INSERT INTO `Position`	
                        (PositionID, PositionName	) 
VALUE 					('1',            'Dev'			),
						( '2',           'Test'			),
						( '3',           'Scrum Master'	),
						( '4',           'PM'			); 

INSERT INTO `Account`(AccountID, Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUE 				(1,			'haidang29productions@gmail.com'	, 'dangblack'		,'Nguyen Hai Dang'		,   '5'			,   '1'		,'2020-03-05'),
					(2,			'account1@gmail.com'				, 'quanganh'		,'Tong Quang Anh'		,   '1'			,   '2'		,'2020-03-05'),
                    (3,			'account2@gmail.com'				, 'vanchien'		,'Nguyen Van Chien'		,   '2'			,   '3'		,'2020-03-07'),
                    (4,			'account3@gmail.com'				, 'cocoduongqua'	,'Duong Do'				,   '3'			,   '4'		,'2020-03-08'),
                    (5,			'account4@gmail.com'				, 'doccocaubai'		,'Nguyen Chien Thang'	,   '4'			,   '4'		,'2020-03-10'),
                    (6,			'dapphatchetngay@gmail.com'		, 'khabanh'			,'Ngo Ba Kha'			,   '6'			,   '3'		,'2020-04-05'),
                    (7,			'songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'		,   '7'			,   '2'		,'2020-04-05'),
                    (8,			'sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'	,   '8'			,   '1'		,'2020-04-07'),
                    (9,			'duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'		,   '9'			,   '2'		,'2020-04-07'),
                    (10,			'vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09');

INSERT INTO `Group`	(GroupID,  GroupName			, CreatorID		, CreateDate)
VALUE 				(1,		'Testing System'		,   5			,'2019-03-05'),
					(2,			'Developement'		,   1			,'2020-03-07'),
                    (3,		'VTI Sale 01'			,   2			,'2020-03-09'),
                    (4,		'VTI Sale 02'			,   3			,'2020-03-10'),
                    (5	,		'VTI Sale 02'			,   4			,'2020-03-28'),
                    (6	,		'VTI Creator'			,   6			,'2020-04-06'),
                    (7	,		'VTI Marketing 01'	,   7			,'2020-04-07'),
                    (8	,		'Management'			,   8			,'2020-04-08'),
                    (9	,		'Chat with love'		,   9			,'2020-04-09'),
                    (10,			'Vi Ti Ai'			,   10			,'2020-04-10');

INSERT INTO GroupAccount	(groupaccountID , GroupID	, AccountID	, JoinDate	 )
VALUE 						(	1,				1		,    1		,'2019-03-05'),
							(	2,				2		,    2		,'2020-03-07'),
							(	3,				4		,    4		,'2020-03-10'),
							(	5, 			    5		,    5		,'2020-03-28'),
							(	6,				6		,    6		,'2020-04-06'),
							(	7,				7		,    7		,'2020-04-07'),
							(	8,				8		,    8		,'2020-04-08'),
							(	9,				9		,    9		,'2020-04-09'),
							(	10,				10		,    10		,'2020-04-10');
                            
INSERT INTO TypeQuestion	(TypeID,TypeName			) 
VALUE 						(	1,	'Essay'			), 
							(	2,	'Multiple-Choice'	); 

INSERT INTO CategoryQuestion		(CategoryID, CategoryName	)
VALUE 								(	1	,	'Java'			),
									(	2	,	'ASP.NET'		),
									(	3	,	'ADO.NET'		),
									(	4	,	'SQL'			),
									(	5,		'Postman'		),
									(	6	,	'Ruby'			),
									(	7,		'Python'		),
									(	8	,	'C++'			),
									(	9,		'C Sharp'		),
									(	10,		'PHP'			);

INSERT INTO Question	(QuestionID, Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUE 					(1	,		'Câu hỏi về Java'	,	1		,   '1'			,   '1'		,'2020-04-05'),
						(2	,		'Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(3	,		'Hỏi về C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(4	,		'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(5	,	'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(6,			'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(7	,		'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(8,			'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(9,			'Hỏi về SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(10,			'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');


INSERT INTO Answer	(AnswerID,  Content		, QuestionID	, isCorrect	)
VALUE 				(	1	,	'Trả lời 01'	,   1			,	0		),
					(2	,	'Trả lời 02'	,   1			,	1		),
                    (	3,		'Trả lời 03'	,   1			,	0		),
                    (	4,		'Trả lời 04'	,   1			,	1		),
                    (	5	,	'Trả lời 05'	,   2			,	1		),
                    (	6,		'Trả lời 06'	,   3			,	1		),
                    (	7	,	'Trả lời 07'	,   4			,	0		),
                    (	8,		'Trả lời 08'	,   8			,	0		),
                    (	9,		'Trả lời 09'	,   9			,	1		),
                    (	10,		'Trả lời 10'	,   10			,	1		);
                    
INSERT INTO Exam	(ExamID,		Code			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUE 				(	1,	'VTIQ001'		, 'Đề thi C#'			,	1			,	70		,   '5'			,'2019-04-05'),
					(	2,	'VTIQ002'		, 'Đề thi PHP'			,	10			,	60		,   '1'			,'2019-04-05'),
                    (	3,	'VTIQ003'		, 'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    (	4,	'VTIQ004'		, 'Đề thi Java'			,	6			,	60		,   '3'			,'2020-04-08'),
                    (	5,	'VTIQ005'		, 'Đề thi Ruby'			,	5			,	120		,   '4'			,'2020-04-10'),
                    (	6,	'VTIQ006'		, 'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    (	7,	'VTIQ007'		, 'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    (	8,	'VTIQ008'		, 'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    (	9,	'VTIQ009'		, 'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    (	10,	'VTIQ010'		, 'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');    



INSERT INTO ExamQuestion(ExamID	,QuestionID) 
VALUE 							(1,1),
								(2,2), 
								(3,3), 
								(4,4), 
								(5,5), 
								(6,6), 
								(7,7), 
								(8,8), 
								(9,9), 
								(10,10); 


-- query --
-- ex2: Lấy tất cả các phòng ban
SELECT * FROM Department;
-- ex3: Lấy ra id của phòng ban "Sale"
SELECT DepartmentID 
FROM Department 
WHERE DepartmentName = 'Sale';

-- ex4:lấy ra thông tin account có full name dài nhất và sắp xếp chúng theo thứ tự giảm dần
SELECT * 
FROM `Account`
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`)
ORDER BY Fullname DESC;

-- ex5:Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT * FROM `Account` 
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`) AND DepartmentID = '3'
ORDER BY Fullname DESC;

-- ex6:lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT GroupName FROM `Group` 
WHERE CreateDate < '2019-12-20';


-- ex7:Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID
FROM Answer
GROUP BY QuestionID
HAVING COUNT(QuestionID)>=4;

-- ex8:Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT Code FROM Exam
WHERE Duration >= 60 AND CreateDate < '2019-12-20';


-- ex9:Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `Group`
ORDER BY CreateDate DESC 
LIMIT 5;

-- ex10:Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(AccountID) AS 'sl' 
FROM Account
WHERE DepartmentID = 2;

-- ex11:Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT Fullname FROM `Account`
WHERE (SUBSTRING_INDEX(FullName, '1 ', 1)) LIKE 'D%o' ;

-- ex12: xóa tất cả các exam được tạo trước ngày 20/12/2019
-- ex13 : xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi" SET FOREIGN_KEY_CHECKS=0;
DELETE FROM Question 
WHERE (SUBSTRING_INDEX(Content,'1',1)) = 'Câu hỏi';

-- ex14: update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account` SET Fullname = 'Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn'
WHERE AccountID = 5;


-- ex15:update account có id = 5 sẽ thuộc group có id = 4
SET FOREIGN_KEY_CHECKS=0;
UPDATE GroupAccount SET AccountID = 5 WHERE GroupID = 4;
SET FOREIGN_KEY_CHECKS=1;
