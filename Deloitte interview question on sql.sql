CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    DateHired DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert data
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, DateHired) VALUES
(1, 'Alice', 'Smith', 1, 50000, '2020-01-15'),
(2, 'Bob', 'Johnson', 1, 60000, '2018-03-22'),
(3, 'Charlie', 'Williams', 2, 70000, '2019-07-30'),
(4, 'David', 'Brown', 2, 80000, '2017-11-11'),
(5, 'Eve', 'Davis', 3, 90000, '2021-02-25'),
(6, 'Frank', 'Miller', 3, 55000, '2020-09-10'),
(7, 'Grace', 'Wilson', 2, 75000, '2016-04-05'),
(8, 'Henry', 'Moore', 1, 65000, '2022-06-17');



--Find the top 3 highest-paid employees in each department.
select concat(e.firstname,e.lastname)as full_name,
       e.salary,
	   d.departmentname
from employees e
join departments d
on e.departmentid = d.departmentid
group by 1,2,3
order by salary desc
limit 3

--Find the average salary of employees hired in the last 5 years.
--using CTE
with kurma as(select *,age(current_date,datehired)as duration
from employees)

select round(avg(salary),2)as avg_Salary
from kurma k
where k.duration <= '5 years'

--another method
select round(avg(salary),2)as avg_Salary 
from employees
where datehired >= current_date - interval '5 years'

--Find the employees whose salary is less than the average salary of employees hired in the last 5 years.
select * from employees
where salary < (select round(avg(salary),2)as avg_Salary 
                from employees
                where datehired >= current_date - interval '5 years')




