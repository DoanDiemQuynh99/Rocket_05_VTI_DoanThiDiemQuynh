use testingsystem;
-- ex1 Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DELIMITER $$
DROP PROCEDURE IF EXISTS bai1;
CREATE PROCEDURE bai1
(IN in_dep_name NVARCHAR(50))
BEGIN
	SELECT 	a.Email, a.Username, a.CreateDate 
    FROM	Department d INNER JOIN `Account` d
    ON		d.DepartmentID = a.DepartmentID
    WHERE	DepartmentName = in_dep_name;
END$$
DELIMITER ;
Call bai1('Sale');

-- ex2 Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS bai2;
DELIMITER $$
CREATE PROCEDURE bai2
(IN in_GroupID TINYINT UNSIGNED)
BEGIN
	SELECT 		ga.GroupID, COUNT(ga.AccountID)
    FROM		GroupAccount ga
    WHERE		ga.GroupID = in_GroupID
    GROUP BY	ga.GroupID;
END$$
DELIMITER ;
call bai2(3);

-- ex3Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS bai3;
DELIMITER $$
CREATE PROCEDURE bai3()
BEGIN
SELECT COUNT(TypeID)
FROM Question
WHERE MONTH(CreateDate) = Month(NOW());
END$$
DELIMITER ;
call bai3(TypeID=3);

-- bai4:Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS bai4;
DELIMITER $$
CREATE PROCEDURE bai4()
BEGIN
	WITH Maxcount AS(
	SELECT COUNT(TypeID)
	FROM Question 
	GROUP BY TypeID
	ORDER BY COUNT(TypeID) DESC
	LIMIT 1)
    
    SELECT TypeID
    FROM Question
    GROUP BY TypeID
    HAVING	COUNT(TypeID) = (SELECT * FROM Maxcount);		
END$$
DELIMITER ;

call bai4 ();

-- bai5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE IF EXISTS bai5;
DELIMITER $$
CREATE PROCEDURE bai5()
BEGIN
	WITH Maxcount AS(
	SELECT COUNT(TypeID)
	FROM Question 
	GROUP BY TypeID
	ORDER BY COUNT(TypeID) DESC
	LIMIT 1)
    
    SELECT 	tq.TypeName
    FROM	Question q INNER JOIN TypeQuestion tq
    ON		q.TypeID = tq.TypeID
    GROUP BY q.TypeID
    HAVING COUNT(q.TypeID) = (SELECT * FROM Maxcount);		
END$$
DELIMITER ;

call bai5();

-- bai 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của
-- người dùng nhập vào

DROP PROCEDURE IF EXISTS bai6;
DELIMITER $$
CREATE PROCEDURE bai6
(IN	in_chuoi VARCHAR(50), IN in_trave TINYINT)
BEGIN
	IF in_trave = 1 THEN
		SELECT 	*
        FROM `Group`
        WHERE GroupName LIKE in_chuoi ;
	ELSE
		SELECT Email, Username, FullName
        FROM `Account`
        WHERE Username LIKE in_chuoi;
END IF;
END$$
DELIMITER ;

call bai6();

-- bai7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS bai7;
DELIMITER $$
CREATE PROCEDURE bai7
(IN in_fullName NVARCHAR(50),IN	in_email VARCHAR(50))
BEGIN
	DECLARE Username VARCHAR(50) DEFAULT SUBSTRING_INDEX(in_email,'@',1);
    DECLARE PositionID TINYINT UNSIGNED DEFAULT 1;
    DECLARE DepartmentID TINYINT UNSIGNED DEFAULT 10;
    DECLARE CreateDate DATETIME DEFAULT NOW();
	INSERT INTO `Account` (Email		,Username, FullName		, DepartmentID,	PositionID,	CreateDate)
    VALUE				  (in_email	,Username, in_fullName	, DepartmentID, PositionID, CreateDate);
    SELECT 	*
    FROM 	`Account`a
    WHERE	a.Username = Username;
END$$
DELIMITER ;



-- bai8 : Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DROP PROCEDURE IF EXISTS bai8
DELIMITER $$
CREATE PROCEDURE bai8
(IN in_TypeName VARCHAR(15))
BEGIN
	IF (in_TypeName = 'Essay') THEN
		SELECT Content, MAX(LENGTH(Content))
		FROM Question
		WHERE TypeID = 1;
	ELSEIF (in_TypeName = 'Multiple-Choice') THEN
		SELECT Content, MAX(LENGTH(Content))
		FROM Question
		WHERE TypeID = 2;
	END IF;
END$$
DELIMITER ;

-- bai9: Viết 1 store cho phép người dùng xóa exam dựa vào ID( input)
DROP PROCEDURE IF EXISTS bai9;
DELIMITER $$
CREATE PROCEDURE bai9
(IN in_ExamID TINYINT UNSIGNED)
BEGIN
	DELETE 	
    FROM Exam 
    WHERE ExamID = in_ExamID;	
    SELECT * FROM Exam;
END$$
DELIMITER ;

call bai9(1);

-- bai 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi, sau đó in số lượng record đã remove từ các table liên quan
-- trong khi removing
DROP PROCEDURE IF EXISTS bai10;
DELIMITER $$
CREATE PROCEDURE bai10()
BEGIN
	WITH ExamID3Year AS(
	SELECT ExamID
	FROM Exam
	WHERE(YEAR(NOW()) - YEAR(CreateDate)) > 3)
    
	DELETE
    FROM Exam
    WHERE ExamID = (
	SELECT * FROM ExamID3Year);
END$$
DELIMITER ;
-- bai 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng
-- ban default là phòng ban chờ việc

DROP PROCEDURE IF EXISTS bai11;
DELIMITER $$
CREATE PROCEDURE bai11
(IN	in_DepName NVARCHAR(50))
BEGIN
	UPDATE 	`Account`
    SET	DepartmentID = 10
    WHERE DepartmentID = (SELECT DepartmentID	
							FROM Department
							WHERE DepartmentName = in_DepName);
	DELETE 
    FROM Department
    WHERE DepartmentName = in_DepName;
END$$
DELIMITER ;

-- bai 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

DROP PROCEDURE IF EXISTS bai12;
DELIMITER $$
CREATE PROCEDURE bai12()
BEGIN
		SELECT sl.MONTH, COUNT(q.QuestionID) AS COUNT
		FROM
		(
		SELECT 1 AS MONTH
		UNION SELECT 2 AS MONTH
		UNION SELECT 3 AS MONTH
		UNION SELECT 4 AS MONTH
		UNION SELECT 5 AS MONTH
		UNION SELECT 6 AS MONTH
		UNION SELECT 7 AS MONTH
		UNION SELECT 8 AS MONTH
		UNION SELECT 9 AS MONTH
		UNION SELECT 10 AS MONTH
		UNION SELECT 11 AS MONTH
		UNION SELECT 12 AS MONTH
        ) AS sl
		LEFT JOIN Question q  ON EachMonthInYear.MONTH = MONTH(CreateDate)
		GROUP BY sl.MONTH
		ORDER BY sl.MONTH ASC;
END$$
DELIMITER ;

-- bai13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
-- tháng gần đây nhất (nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào
-- trong tháng")


DROP PROCEDURE IF EXISTS bai13;
DELIMITER $$
CREATE PROCEDURE bai13()
BEGIN
		SELECT sl.MONTH, COUNT(QuestionID) AS COUNT
		FROM
		(
			SELECT MONTH(CURRENT_DATE - INTERVAL 5 MONTH) AS MONTH
			UNION
			SELECT MONTH(CURRENT_DATE - INTERVAL 4 MONTH) AS MONTH
			UNION
			SELECT MONTH(CURRENT_DATE - INTERVAL 3 MONTH) AS MONTH
			UNION
			SELECT MONTH(CURRENT_DATE - INTERVAL 2 MONTH) AS MONTH
			UNION
			SELECT MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AS MONTH
			UNION
			SELECT MONTH(CURRENT_DATE - INTERVAL 0 MONTH) AS MONTH
        ) AS sl
		LEFT JOIN Question q ON sl.MONTH = MONTH(CreateDate)
		GROUP BY sl.MONTH
		ORDER BY sl.MONTH ASC;
END$$
DELIMITER ;