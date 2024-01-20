

Drop table if exists tbldepartment;

Create table tbldepartment
(
ID int Primary Key,
DepartmentName varchar(50),
Location varchar(50),
DepartmentHead varchar(50)
);

insert into tbldepartment values (1,'IT','London','Rick');
insert into tbldepartment values (2,'Payroll','Delhi','Ron');
insert into tbldepartment values (3,'HR','New York','Christie');
insert into tbldepartment values (4,'Other Department','Sydney','Cindrella');

select * from tbldepartment;



drop table if exists tblEmployee;
create table tblemployee
(
ID int primary key,
Name varchar (50),
Gender varchar (50),
Salary int,
Departmentid int,
Foreign Key (Departmentid) references tblDepartment(id)
);


select * from tblEmployee;


INSERT INTO tblemployee values (1,'Tom','Male',4000,1);
INSERT INTO tblemployee values (2,'Pam','Female',3000,3);
INSERT INTO tblemployee values (3,'John','Male',3500,1);
INSERT INTO tblemployee values (4,'Sam','Male',4500,2);
INSERT INTO tblemployee values (5,'Todd','Male',2800,2);
INSERT INTO tblemployee values (6,'Ben','Male',7000,1);
INSERT INTO tblemployee values (7,'Sara','Female',4800,3);
INSERT INTO tblemployee values (8,'Valarie','Female',5500,1);
INSERT INTO tblemployee values (9,'James','Male',6500,NULL);
INSERT INTO tblemployee values (10,'Russell','Male',8800,NULL);


select * from tblemployee inner join tbldepartment on Departmentid = tbldepartment.ID;



select * from tblemployee;


select * from tblemployee inner join tbldepartment on Departmentid = tbldepartment.ID;


select * from tblemployee left join tbldepartment on Departmentid = tbldepartment.ID;



select * from tblemployee left join tbldepartment on Departmentid = tbldepartment.ID;

select * from tblemployee right join tbldepartment on Departmentid = tbldepartment.ID;




select * from tblemployee left join tbldepartment on Departmentid = tbldepartment.ID
UNION
select * from tblemployee right join tbldepartment on Departmentid = tbldepartment.ID;



select Name,DepartmentName,Location  from tblemployee left join tbldepartment on Departmentid = tbldepartment.ID;


select Name,DepartmentName,Location  from tblemployee left join tbldepartment on Departmentid = tbldepartment.ID
where tbldepartment.ID = 1;



select Name,DepartmentName,Location  from tblemployee join 
tbldepartment on Departmentid = tbldepartment.ID
where tbldepartment.ID = 1;


select Name,DepartmentName,Location  from tblemployee, tbldepartment  
 where Departmentid = tbldepartment.ID and  tbldepartment.ID = 1;





select e.first_name, e.last_name 
from employees e
where e.emp_no  in (select dm.emp_no from dept_manager dm);

select dm.emp_no from dept_manager dm;

select * from dept_manager;


select e.first_name, e.last_name 
from employees e
where e.emp_no  in (select dm.emp_no from dept_manager dm);


select distinct e.first_name, e.last_name 
from employees e
where e.emp_no  not in (select dm.emp_no from dept_manager dm);

select e.first_name, e.last_name 
from employees e join dept_manager dm
on e.emp_no = dm.emp_no;



SELECT * FROM dept_manager WHERE emp_no IN 
(SELECT  emp_no FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');


select * from departments ;

select * from departments where dept_name = 'Finance' or dept_name = 'Marketing';

select * from departments where dept_name IN ('Finance', 'Marketing');

select * from departments where dept_name NOT IN ('Finance', 'Marketing');



select * from departments where dept_name 
IN (select dept_name from departments where dept_name IN ('Finance', 'Marketing'));



select * from departments where EXISTS (select dept_name from departments where dept_name IN ('Finance', 'Marketing'));


select * from departments where EXISTS (select dept_name from departments where dept_name IN ('Sunday','Market'));





SELECT * FROM employees e WHERE EXISTS 
(SELECT * FROM titles t WHERE t.emp_no = e.emp_no AND title = 'Assistant Engineer');




select  A.*  from 
(select e.emp_no as employee_id , min(de.dept_no) as department_code,
(select emp_no From dept_manager where emp_no =110022) as manager_id
from employees e 
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no <= 10020
group by e.emp_no order by e.emp_no ) A
UNION 
Select B.* from 
(select e.emp_no as employee_id , min(de.dept_no) as department_code,
(select emp_no From dept_manager where emp_no =110039) as manager_id
from employees e 
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no>10020
group by e.emp_no order by e.emp_no LIMIT 20) B;





SELECT  A.* FROM (SELECT  e.emp_no AS employee_ID,MIN(de.dept_no) AS department_code, 
(SELECT  emp_no FROM  dept_manager WHERE emp_no = 110022) AS manager_ID  
FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no WHERE e.emp_no <= 10020   
 GROUP BY e.emp_no ORDER BY e.emp_no) as A;





SELECT  b.* FROM (SELECT  e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code,            (SELECT  emp_no FROM dept_manager WHERE emp_no = 110039) AS manager_ID 
FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no   
WHERE e.emp_no > 10020 GROUP BY e.emp_no ORDER BY e.emp_no LIMIT 20) AS b ;   






SELECT u.* FROM
(SELECT  a.* FROM (SELECT  e.emp_no AS employee_ID,MIN(de.dept_no) AS department_code, (SELECT  emp_no FROM  dept_manager WHERE emp_no = 110022) AS manager_ID  
FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no WHERE e.emp_no <= 10020    GROUP BY e.emp_no ORDER BY e.emp_no) AS a    
UNION   
SELECT  b.* FROM (SELECT  e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code,            (SELECT  emp_no FROM dept_manager WHERE emp_no = 110039) AS manager_ID 
FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no   
WHERE e.emp_no > 10020 GROUP BY e.emp_no ORDER BY e.emp_no LIMIT 20) AS b    
UNION   
SELECT  c.* FROM (SELECT  e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code,            (SELECT emp_no FROM dept_manager WHERE emp_no = 110039) AS manager_ID   
FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE  e.emp_no = 110022 GROUP BY e.emp_no) AS c     
UNION   
SELECT d.* FROM (SELECT  e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code,            (SELECT emp_no FROM dept_manager WHERE emp_no = 110022) AS manager_ID   
FROM employees e  JOIN dept_emp de ON e.emp_no = de.emp_no   
WHERE e.emp_no = 110039    GROUP BY e.emp_no) AS d) as u;



select * from emp_manager;



Drop table if exists tblEmployees;

Create table tblEmployees
(	
EmployeeID int,  
Name varchar(50),    
ManagerID int 
); 



insert into tblEmployees values (1, 'Mike',3);
insert into tblEmployees values (2, 'Rob',1);
insert into tblEmployees values (3, 'Todd',NULL);
insert into tblEmployees values (4, 'Ben',1);
insert into tblEmployees values (5, 'Sam',1);


select *  from tblEmployees;


select distinct e1.* from tblEmployees e1
join tblEmployees m1 on m1.EmployeeID = e1.ManagerID;


select  e1.EmployeeID, e1.Name as EMP_NAME ,m1.Name as MGR_NAME 
from tblEmployees e1
join tblEmployees m1 on m1.EmployeeID = e1.ManagerID
order by e1.EmployeeID ;



select distinct e1.* from tblEmployees e1 join tblEmployees m1 on m1.EmployeeID = e1.ManagerID;



select e1.* from tblEmployees e1 join tblEmployees e2 
on e1.EmployeeID  = e2.ManagerID
where e1.EmployeeID IN (SELECT ManagerID from tblEmployees);


select  e1.EmployeeID, e1.Name as EMP_NAME ,m1.Name as MGR_NAME 
from tblEmployees e1 
join tblEmployees m1 on m1.EmployeeID = e1.ManagerID
 order by e1.EmployeeID ;




select  e1.EmployeeID, e1.Name as EMP_NAME ,m1.Name as MGR_NAME
 from tblEmployees e1
 join tblEmployees m1 on m1.EmployeeID = e1.ManagerID
 order by e1.EmployeeID ;





CREATE OR REPLACE VIEW v_dept_emp_latest_date as
SELECT emp_no, MAX(from_date) AS from_date , MAX(to_date) as to_date 
from dept_emp group by emp_no; 


select * from v_dept_emp_latest_date;



CREATE OR REPLACE VIEW v_manager_avg_salary AS    SELECT ROUND(AVG(salary), 2)    
 FROM salaries s JOIN dept_manager m ON s.emp_no = m.emp_no;  


select * from v_manager_avg_salary;

select * from employees;



DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee
(
Name VARCHAR(255), 
Salary INT NOT NULL,
Location VARCHAR(255)
);



DELIMITER //




Create procedure myProcedure (IN name VARCHAR(30),   IN sal INT,   IN loc VARCHAR(45))  
BEGIN   
   INSERT INTO Employee(Name, Salary, Location) VALUES (name, sal, loc);  
END //     



DELIMITER ;


CALL myProcedure ('Raman', 35000, 'Bangalore');

select * from Employee;

CALL myProcedure ( 35000, 'Bangalore');



select * from employee;


DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$

CREATE PROCEDURE select_employees()
BEGIN 
select * from employees limit 1000;
END$$

DELIMITER ;


call employees.select_employees();



call select_employees();


select * from Employee;

DROP Procedure select_employees;



USE EMPLOYEES;

DROP PROCEDURE IF EXISTS EMP_SALARY;

DELIMITER $$

USE EMPLOYEES $$

CREATE PROCEDURE EMP_SALARY (IN P_EMP_NO INTEGER)
BEGIN 	
SELECT E.FIRST_NAME , E.LAST_NAME, S.SALARY, S.FROM_DATE, S.TO_DATE     
FROM EMPLOYEES E JOIN SALARIES S ON E.EMP_NO = S.EMP_NO  
WHERE E.EMP_NO = P_EMP_NO; 
END $$  

DELIMITER ; 




CALL EMP_SALARY (11300);



USE EMPLOYEES;

DROP PROCEDURE IF EXISTS EMP_AVG_SALARY;

DELIMITER $$

USE EMPLOYEES $$

CREATE PROCEDURE EMP_AVG_SALARY (IN P_EMP_NO INTEGER)
BEGIN 	
SELECT E.FIRST_NAME , E.LAST_NAME, AVG(S.SALARY)    
FROM EMPLOYEES E JOIN SALARIES S ON E.EMP_NO = S.EMP_NO  
WHERE E.EMP_NO = P_EMP_NO
GROUP BY E.EMP_NO ;  
END $$  

DELIMITER ; 


CALL EMP_AVG_SALARY (11300);


USE EMPLOYEES;

DROP PROCEDURE IF EXISTS EMP_AVG_SALARY_OUT;

DELIMITER $$

USE EMPLOYEES $$



CREATE PROCEDURE EMP_AVG_SALARY_OUT (IN P_EMP_NO INTEGER, OUT P_AVG_SALARY DECIMAL (10.2))
BEGIN 	
SELECT AVG(S.SALARY) INTO P_AVG_SALARY 
FROM EMPLOYEES E JOIN SALARIES S ON E.EMP_NO = S.EMP_NO  
WHERE E.EMP_NO = P_EMP_NO
GROUP BY E.EMP_NO ;  
END $$  


DELIMITER ; 





CALL EMP_AVG_SALARY_OUT (11300, @P_AVG_SALARY);


select @P_AVG_SALARY as avg_sal;





USE EMPLOYEES;

DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$

CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
BEGIN        
       SELECT e.emp_no INTO p_emp_no FROM employees e    
       WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
END$$

DELIMITER ;

CALL emp_info ('Parto', 'Bamford',@p_emp_no);


SELECT @p_emp_no as emp_no; 


SET @p_avg_salary =0;


CALL employees.EMP_AVG_SALARY_OUT (11300, @p_avg_salary);



select @p_avg_salary; 



USE employees;

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$

CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL (10,2)
DETERMINISTIC NO SQL READS SQL DATA 
BEGIN 
DECLARE v_avg_salary DECIMAL (10,2);
SELECT AVG(s.salary) INTO v_avg_salary FROM employees e 
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;RETURN v_avg_salary;
END $$

DELIMITER ; 



SELECT f_emp_avg_salary (11300) as AVG_SAL;

USE employees;

DROP FUNCTION IF EXISTS emp_info;

DELIMITER $$




CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) 
RETURNS decimal(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN                
DECLARE v_max_from_date date;      
DECLARE v_salary decimal(10,2);
SELECT  MAX(from_date) INTO v_max_from_date  FROM  employees e  
JOIN salaries s ON e.emp_no = s.emp_no 
WHERE e.first_name = p_first_name  AND e.last_name = p_last_name;

SELECT  s.salary INTO v_salary FROM employees e  
JOIN  salaries s ON e.emp_no = s.emp_no 
WHERE   e.first_name = p_first_name   AND e.last_name = p_last_name
 AND s.from_date = v_max_from_date;        
         RETURN v_salary;                 
END$$

DELIMITER ;


SELECT EMP_INFO('Aruna', 'Journel') as salary;


