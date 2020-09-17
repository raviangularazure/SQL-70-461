create table tblTransaction(
Amount smallmoney not null,
DateofTransaction smalldatetime null,
EmployeeNumber int not null) -- this will become an FK later

-- When designing tables do it in a spreadsheet. Its easier and you can make more meaningful designs
-- start creating Db diagrams by selecting tables to view their relationships

select count(*) from tblEmployee; select count(*) from tblTransaction

select e.EmployeeNumber, e.EmployeeFirstName, sum(t.Amount) as SumAmount from tblEmployee e 
join tblTransaction t on e.EmployeeNumber = t.EmployeeNumber 
group by e.EmployeeNumber, e.EmployeeFirstName
order by EmployeeNumber -- No alias needed

-- The joins are part of the from clause always. So any where or group by will happen after the from only.

select * from tblEmployee -- 393 records. You will get same records in above query by changing to left join

-- inner join - only rows matching join condition in both tables.
-- left join - all rows in left + matching rows in right.
-- right join - just the other way around. Never used
-- cross join - result is ALWAYS a cartesian product (no of rows of left table x no of rows of right table). Hardly used

-- So in principal only Inner and Left join is almost always used

-- The result of a query can be considered as a new table. A table is a set of records in a stack of sheets.
-- Always look at results and compare it with data in the tables used and make sure they make sense.

select Department from
(select Department, count(*) as NoofPeopleInDepartment from tblEmployee
group by department) as result -- derived table.

select distinct department from tblEmployee -- another way of writing above query.

select distinct department, N'' as departmentHead -- check the data types for these 2 columns.
into tblDepartment -- into will create a brand new table and inserts values into it.
from tblEmployee

drop table tblDepartment

alter table tblDepartment
alter column departmentHead nvarchar(30) null

-- Find non matching rows - Using Left join and Null condition

select e.EmployeeNumber as EmpNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber, sum(t.Amount) from 
tblEmployee e left join tblTransaction t on e.EmployeeNumber = t.EmployeeNumber
where t.EmployeeNumber is null -- find details of employees who have no transactions
group by e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber
order by EmpNumber

-- same query using derived table

select * from(
select e.EmployeeNumber as EmpNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber, sum(t.Amount) as TotalSum from 
tblEmployee e left join tblTransaction t on e.EmployeeNumber = t.EmployeeNumber
group by e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber) as result -- derived table
where EmployeeNumber IS NULL
order by EmpNumber

-- find out Phantom rows in tblTransaction table. Pahntom rows => Rows that don't have a matching row in tblEmployee
begin tran
select count(*) from tblTransaction
delete tblTransaction 
from tblEmployee as E right join tblTransaction T on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeNumber is null 
select count(*) from tblTransaction
rollback tran	

-- this can be done via a Derived table as well.

begin tran
select count(*) from tblTransaction
delete from tblTransaction where EmployeeNumber in(
Select TEmpNumber from(
select e.EmployeeNumber as EEmpNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber as TEmpNumber, sum(t.Amount) as TotalSum from 
tblEmployee e right join tblTransaction t on e.EmployeeNumber = t.EmployeeNumber
group by e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber) as result -- derived table
where EEmpNumber IS NULL)
select count(*) from tblTransaction
rollback tran -- The begin and rollback tran is so that we can keep testing this queries without losing the data in the table

-- update all employee number to 1001 which are between 900 and 1000
begin tran
update tblTransaction
set EmployeeNumber = 1001
output inserted.*, deleted.* -- output will output the result.
where EmployeeNumber between 900 and 1000
rollback tran
-- inserted and deleted temporary tables. They are sql generated tables created during Update
