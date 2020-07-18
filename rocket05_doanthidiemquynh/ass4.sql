use testingsystem;
/*ex1*//*cau1*/
select account.AccountID, account.Username, department.DepartmentID, department.DepartmentName
From account 
join 
department on account.DepartmentID=department.DepartmentID
order by DepartmentID;

/*cau3*/
select position.PositionName='Dev', account.Username, account.PositionID
From account 
join 
position  on account.PositionID= position.PositionID
order by PositionID;

/*cau4*/
select account.AccountID, account.Username, department.DepartmentID, department.DepartmentName
From account 
join 
department on account.DepartmentID=department.DepartmentID
group by DepartmentID having count(Username>3)
order by DepartmentID;

/*cau5  Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều
nhất*/
select question.QuestionID, count 
from exam
join 
examquestion on question.ExamID= examquestion.ExamID
order by examID;

/*cau 6:Thông kê mỗi category Question được sử dụng trong bao nhiêu Question DAT*/
select categoryquestion.CategoryID, categoryquestion.CategoryName, question.QuestionID, count(categoryquestion.CategoryID)
from categoryquestion
left join 
question on question.CategoryID= categoryquestion.CategoryID
group by CategoryID
order by CategoryID;


/*cau7: thong ke moi question được sử dụng trong bao nhiêu Exam*/
select  question.QuestionID, question.Content , examquestion.ExamID, count(question.QuestionID)
from question
left join 
examquestion on question.QuestionID=examquestion.QuestionID
group by QuestionID
order by Content;

SELECT q.QuestionID, q.Content, count(eq.ExamID) as number_of_exams
FROM question q
LEFT JOIN examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY eq.QuestionID
ORDER BY q.QuestionID;

SELECT		Q.Content, COUNT(EQ.QuestionID)
FROM		Question Q LEFT JOIN ExamQuestion EQ
ON			EQ.QuestionID = Q.QuestionID
GROUP BY	Q.QuestionID
ORDER BY 	EQ.ExamID ASC;


/*cau8:Lấy ra Question có nhiều câu trả lời nhất*/
SELECT q.QuestionID, q.Content, a.Answers, count(a.QuestionID) as 'sl'
FROM question q
INNER JOIN answer a ON q.QuestionID=a.QuestionID
GROUP BY a.QuestionID
HAVING count(a.QuestionID) = (SELECT Max(CountQuestion)
										FROM (SELECT count(a.QuestionID) as CountQuestion
												FROM question q 
												RIGHT JOIN answer a ON q.QuestionID =  a.QuestionID
												GROUP BY a.QuestionID) as MaxCount);
					
                        


-- 8
SELECT 		Q.QuestionID, Q.Content, COUNT(A.QuestionID) AS 'SO LUONG'
FROM		Question Q INNER JOIN Answer A 
ON			Q.QuestionID = A.QuestionID
GROUP BY	A.QuestionID
HAVING		COUNT(A.QuestionID) =	(SELECT 	MAX(CountQ)
									FROM		(SELECT 		COUNT(A.QuestionID) AS CountQ
												FROM			Answer A RIGHT JOIN  Question Q 
												ON				A.QuestionID = Q.QuestionID 
												GROUP BY		A.QuestionID) AS MaxCountQ);
			

/*cau9:Thống kê số lượng account trong mỗi group*/ 
SELECT g.GroupID, g.GroupName, count(ga.AccountID) as 'sl'
FROM  groupaccount ga
RIGHT JOIN `Group` g ON ga.GroupID=g.GroupID
GROUP BY ga.GroupID
ORDER BY ga.GroupID ASc;

SELECT		G.GroupID, COUNT(GA.AccountID) AS 'SO LUONG'
FROM		GroupAccount GA 
RIGHT JOIN 	`Group` G ON	GA.GroupID = G.GroupID
GROUP BY	G.GroupID
ORDER BY	G.GroupID ASC;



/*cau10:Tìm chức vụ có ít người nhất*/
SELECT p.PositionID, COUNT(p.PositionID)
FROM position p 
RIGHT JOIN `account` a ON p.PositionID= a.PositionID
GROUP BY a.PositionID
HAVING COUNT(p.PositionID) = (SELECT MIN(CountMin)
								FROM (SELECT COUNT(p.PositionID) as CountMin 
									  FROM position p 
									  RIGHT JOIN `account` a ON p.PositionID= a.PositionID
									  GROUP BY a.PositionID
									  ORDER BY a.PositionID) AS MIN_1);
                                      
/*cau 11:thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM*/
SELECT p.PositionID, p.PositionName, count(a.PositionID) as 'SL'
FROM `account`a
INNER JOIN Department d ON d.DepartmentID = a.DepartmentID
INNER JOIN Position p ON p.PositionID = a.PositionID
GROUP BY a.PositionID
ORDER BY a.AccountID 

/*cau 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …*/
select q.Content, tq.TypeName, q.CreatorID, a.Answers
from question q
join  answer a on q.QuestionID=a.QuestionID
join typequestion tq on q.TypeID=tq.TypeID
group by Content
order by Content

/*cau 13: lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm */

SELECT q.QuestionID, tq.TypeName, count(q.QuestionID)
FROM question q
INNER JOIN typequestion tq ON q.TypeID=tq.TypeID
GROUP BY q.TypeID
ORDER BY q.QuestionID;

/*cau 14lấy ra group không có account nào*/
SELECT *, COUNT(ga.GroupID)  as Soluong
FROM `Group` g
LEFT JOIN GroupAccount ga
	ON g.GroupID = ga.GroupID
GROUP BY g.GroupID
HAVING Soluong = 0;
-- CHUA BAI
SELECT		*
FROM		`Group` 
WHERE		GroupID  NOT IN
					(SELECT		GroupID
					FROM		GroupAccount);
/*cau 15,16 lấy ra question không có answer nào*/
SELECT *, count(a.QuestionID) as SL
FROM question q
LEFT JOIN  answer a ON  q.QuestionID=a.QuestionID
GROUP BY q.QuestionID
HAVING SL = 0;









/*union*/
/*bai1 caua: Lấy các account thuộc nhóm thứ 1*/
select  `account`.Username
from `account`
UNION 
SELECT GroupID FROM groupaccount where GroupID='1'

/*bai1 caub: Lấy các account thuộc nhóm thứ 2*/
/*bai1 cauc: Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau*/


/*trigger*/
select 'dev' from position