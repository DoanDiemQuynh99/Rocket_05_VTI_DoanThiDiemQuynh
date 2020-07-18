-- bai1 Tạo view có chứa danh sách nhân viên thuộc phòng ban sale--
use testingsystem;
Drop view Bai1;
CREATE VIEW Bai1 AS
   SELECT a.*, d.DepartmentName
   FROM `account` a 
   INNER JOIN 
			department d 
	ON a.DepartmentID= d.DepartmentID
    where d.DepartmentName = 'Sale'
    Group By d.DepartmentID;

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
WHERE	LENGTH(Content) > 18 

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
from view Bai4 ;
 -- bai 5:Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo                             
CREATE OR REPLACE VIEW vw_QuesHoNguyen
AS
SELECT 		Q.*, A.FullName
FROM 		Question Q INNER JOIN `Account` A
ON			Q.CreatorID = A.AccountID
WHERE		SUBSTRING_INDEX(FullName,' ',1) = 'Nguyen';

SELECT * FROM vw_QuesHoNguyen;


   
   
   
   
   
   
   
   
   

-- bai 2 ---

CREATE VIEW Thongtin AS
    SELECT 
        `account`.Fullname,
        groupaccount.AccountID,
        COUNT(groupaccount.AccountID)
    FROM
        `account`
            JOIN
        groupaccount ON groupaccount.AccountID = `account`.AccountID
    GROUP BY `account`.AccountID
    HAVING COUNT(groupaccount.AccountID) = (SELECT 
												COUNT(groupaccount.AccountID)
											FROM
													`account`
														JOIN
														groupaccount ON groupaccount.AccountID = `account`.AccountID
        										GROUP BY `account`.AccountID limit 1);
    


-- fg
CREATE OR REPLACE VIEW vw_InfAccountMaxGroup
AS
SELECT 		A.*, COUNT(GA.AccountID) AS 'SO LUONG'
FROM		`Account` A 
INNER JOIN 	GroupAccount GA ON A.AccountID = GA.AccountID
GROUP BY	A.AccountID
HAVING		COUNT(GA.AccountID) = (
									SELECT 		COUNT(GA.AccountID) 
									FROM		`Account` A 
									INNER JOIN 	GroupAccount GA ON A.AccountID = GA.AccountID
									GROUP BY	A.AccountID
									ORDER BY	COUNT(GA.AccountID) DESC
									LIMIT		1
								  );
								  
SELECT 	* 
FROM 	vw_InfAccountMaxGroup;



-- bai 4
create view Danhsach as
select department.DepartmentName, `account`.Username,`account`.AccountID, count(`account`.AccountID) as SL
from department 
join `account` on department.DepartmentID= `account`.DepartmentID
group by Username

having count(`account`.AccountID) = (	
									select count(`account`.AccountID)
                                    from department 
                                    join `account` on department.DepartmentID= `account`.DepartmentID
									group by Username
									order by Username  asc
                                    limit 1);

-- anh duy
SELECT 		D.*, COUNT(A.DepartmentID)
	FROM		Department D 
	INNER JOIN 	`Account` A ON D.DepartmentID = A.DepartmentID
	GROUP BY	D.DepartmentID
	HAVING		COUNT(A.DepartmentID) = (
										SELECT 		COUNT(A.DepartmentID)
										FROM		Department D 
										INNER JOIN 	`Account` A ON D.DepartmentID = A.DepartmentID
										GROUP BY	D.DepartmentID
										HAVING		COUNT(A.DepartmentID)
										ORDER BY	COUNT(A.DepartmentID) DESC
										LIMIT		1
                                        
                                        
-- bai 5 Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
create view bai5
select question.content, `account`.Fullname
from question
join `account` on `account`.AccountID=question.CreatorID
WHERE	SUBSTRING_INDEX(FullName,' ',1) = 'Nguyen';


