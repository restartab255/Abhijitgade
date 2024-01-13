create database HR; 
select * from hr_2;
select count(*) from hr_2;
select count(*) from hr_2;

-- Q.1 Average Attrition rate for all Departments

create view KPI_1
as
select a.Department, concat(format(avg(a.attrition_y)*100,2),'%') as Attrition_Rate
from  
( select department,attrition,
case when attrition='Yes'
then 1
Else 0
End as attrition_y from hr_1 ) as a
group by a.department;
select * from kpi_1;

-- Q.2 Average Hourly rate of Male Research Scientist

create view KPI_2
as
select avg(hourlyrate) ,gender,JobRole from hr_1
where JobRole='Research Scientist' and Gender="male";

select * from KPI_2;

alter table hr_2 rename column  `Employee ID` to `employeenumber`;
-- Q.3 Attrition rate Vs Monthly income stats

create view KPI_3
as
select a.department, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_attrition,format(avg(b.monthlyincome),2) as Average_Monthly_Income
from ( select department,attrition,EmployeeNumber ,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on b.EmployeeNumber= a.EmployeeNumber
group by a.department;

-- Q.4 Average working years for each Department


create view KPI_4
as
select a.department, format(avg(b.TotalWorkingYears),1) as Average_Working_Year
from hr_1 as a
inner join hr_2 as b on b.Employeenumber =a.Employeenumber
group by a.department; 

-- Q.5 Job Role Vs Work life balance

create view KPI_5
as
select a.JobRole,
sum(case when performancerating = 1 then 1 else 0 end) as 1st_Rating_Total,
sum(case when performancerating = 2 then 1 else 0 end) as 2nd_Rating_Total,
sum(case when performancerating = 3 then 1 else 0 end) as 3rd_Rating_Total,
sum(case when performancerating = 4 then 1 else 0 end) as 4th_Rating_Total, 
count(b.performancerating) as Total_Employee, format(avg(b.WorkLifeBalance),2) as Average_WorkLifeBalance_Rating
from hr_1 as a
inner join hr_2 as b on b.Employeenumber = a.EmployeeNumber
group by a.jobrole;

-- Q.6 Attrition rate Vs Year since last promotion relation

create view KPI_6
as
select a.JobRole,concat(format(avg(a.attrition_rate)*100,2),'%') as Average_Attrition_Rate,
format(avg(b.YearsSinceLastPromotion),2) as Average_YearsSinceLastPromotion
from ( select JobRole,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on b.employeenumber = a.employeenumber
group by a.JobRole;






