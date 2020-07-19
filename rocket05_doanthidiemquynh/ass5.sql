-- bai1 Tạo view có chứa danh sách nhân viên thuộc phòng ban sale--
USE testingsystem;
DROP VIEW Bai1;
CREATE VIEW Bai1 AS
   SELECT a.*, d.DepartmentName
   FROM `account` a 
   INNER JOIN 
			department d 
	ON a.DepartmentID= d.DepartmentID
    WHERE d.DepartmentName = 'Sale'
    GROUP BY d.DepartmentID;

SELECT   *
FROM  Bai1 ;

-- bai 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE VIEW Bai2 AS
	SELECT a.*, count(ga.AccountID)
    FROM	`account` a
    INNER JOIN	groupaccount ga
    ON		a.AccountID=ga.AccountID
    GROUP BY ga.GroupID
    HAVING	count(ga.AccountID)	=(SELECT Max(SL) 
								  FROM (SELECT Count(ga.AccountID) as SL
										FROM `account` a
                                        INNER JOIN groupaccount ga ON a.AccountID=ga.AccountID
                                        GROUP BY ga.GroupID
                                        ORDER BY ga.GroupID) As Maxcount);
										
-- bai 3:tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi    
 CREATE VIEW Bai3 AS
	SELECT 	LENGTH(Content)
FROM	Question
WHERE	LENGTH(Content) > 18 ;

-- bai4:Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
Drop view Bai4;
CREATE VIEW Bai4 AS
SELECT d.* , count(a.AccountID)
FROM `account` a
INNER JOIN department d ON a.DepartmentID=d.DepartmentID
GROUP BY  a.AccountID
HAVING count(a.AccountID)      =(SELECT max(SL)
							     FROM	(SELECT count(a.AccountID)AS SL
										FROM `account` a
										INNER JOIN department d ON a.DepartmentID=d.DepartmentID
										GROUP BY a.AccountID
										ORDER BY a.AccountID) AS Maxcount);
/*using*/ 
select d.DepartmentID, d.DepartmentName
from view Bai4;
            
															
-- bai 5 Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
Drop view Bai5;
create OR REPLACE view bai5 as
select question.content, `account`.Fullname
from question
 inner join `account` on `account`.AccountID=question.CreatorID
WHERE	SUBSTRING_INDEX(FullName,' ',1) = 'Nguyen';

SELECT * FROM bai5
