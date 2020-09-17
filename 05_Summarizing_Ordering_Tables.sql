select * from tblEmployee where DateOfBirth between '19500101' and '19700101'

select year(dateofbirth) as yearofDOB from tblEmployee order by yearofDOB -- order by always executes finally after Select

select year(dateofbirth) as yearofDOB, count(*) as TotalCount from tblEmployee -- summary column requires other columns to be grouped
where year(DateOfBirth) > 1970 group by year(dateofbirth) 
order by yearofDOB desc -- add this ordering as required

-- The order in which Sql server executes above query is something like in below order:
-- from tblEmployee where year(DateOfBirth) > 1970  group by year(dateofbirth)
-- then select year(dateofbirth), count(*) as yearofDOB in above
-- This is why you cannot use the "alias name in group by. You can only use non alias columns in group by.

select top(5) year(dateofbirth) as yearofDOB, count(*) as yearofDOB from tblEmployee
where year(DateOfBirth) > 1970 group by year(dateofbirth)
order by count(*) desc -- order by year which has most employee DOBs and only the top 5


select year(dateofbirth) as yearofDOB, count(*) as CountofYear from tblEmployee
where year(DateOfBirth) > 1970 group by year(dateofbirth) 
having count(*) > 10 -- apply condition post the grouping
order by CountofYear desc -- order by year which has most employee DOB

select datename(month, Dateofbirth) as MonthName, count(*) from tblEmployee
group by datename(month, Dateofbirth),datepart(month, Dateofbirth) -- group by datepart so that we can order by month
order by datepart(month, Dateofbirth)

-- I can group by something that is not there in the Select.

select datename(month, Dateofbirth) as MonthName, count(*) as NoOfEmployees
,count(EmployeeMiddleName) as NumberofMiddleNames
,count(*)-count(EmployeeMiddleName) as NoMiddleNames
,min(DateOfBirth) as EarliestDOB
,max(DateOfBirth) as OldestDOB
from tblEmployee
group by datename(month, Dateofbirth),datepart(month, Dateofbirth) -- group by datepart so that we can order by month
order by datepart(month, Dateofbirth)

-- The above example shows multiple summarizing columns