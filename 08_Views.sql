select D.Department, T.EmployeeNumber, T.DateofTransaction, T.Amount
from tblDepartment as D 
left join tblEmployee as E on D.Department = e.Department
left join tblTransaction as T on T.EmployeeNumber = e.EmployeeNumber
where T.EmployeeNumber between 900 and 1100
order by Department, EmployeeNumber

select D.Department, T.EmployeeNumber, sum(T.Amount) as TotalAmount
from tblDepartment as D 
left join tblEmployee as E on D.Department = e.Department
left join tblTransaction as T on T.EmployeeNumber = e.EmployeeNumber
group by D.Department, T.EmployeeNumber
order by Department, EmployeeNumber
go
-- Example queries above that can be put as views. Join columns from multiple tables to make it look like a single table.

create view ViewBySummary as 
select top(100) percent D.Department, T.EmployeeNumber, sum(T.Amount) as TotalAmount -- top(100) percent is needed if you use order by in a view. Generally avoid order by in views. Do the ordering on the select query of the view
from tblDepartment as D 
left join tblEmployee as E on D.Department = e.Department
left join tblTransaction as T on T.EmployeeNumber = e.EmployeeNumber
group by D.Department, T.EmployeeNumber
order by Department, EmployeeNumber --  -- The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.
go -- a view must run in its own separate batch.

select * from ViewBySummary
go

create view ViewByDepartment as -- with encryption as 
select D.Department, T.EmployeeNumber, T.DateofTransaction, T.Amount
from tblDepartment as D 
left join tblEmployee as E on D.Department = e.Department
left join tblTransaction as T on T.EmployeeNumber = e.EmployeeNumber
where T.EmployeeNumber between 900 and 1100
-- with check option
go

select * from ViewByDepartment

-- Alter view - Just script as Alter View from Object Explorer

drop view ViewByDepartment -- to drop a view

select * from sys.views -- list the views of the database
-- Similarily you have sys.tables for all tables etc. But INFORMATION_SCHEMA.TABLES is a better check since it checks both table name and the schemas

if exists(Select 1 from sys.views where name = 'ViewByDepartment') -- use this to check if view exists
begin 
	drop view ViewByDepartment -- to drop a view
end

select * from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'ViewByDepartment' and TABLE_SCHEMA = 'dbo' 
-- Use this if you want to check by both view name and schema name. 

select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'tblEmployee' and TABLE_SCHEMA = 'dbo' 

select sv.name, sc.text from sys.syscomments sc 
join sys.views sv on sv.object_id = sc.id -- get the code of the view

-- now drop the view and recreate with encryption as and then rerun the above query. You wont be able to see the code of the view. You can also try Script as Create on the view.

-----Security ------ Actually this explanation applies for all objects in the db

-- Schema - e.g. dbo => Used to Group db objects (Tables, views, procedures). Then it becomes easy to assign permissions to the schema(group)

-- So I have access to dbo so, dbo.ViewDepartment => This view queries dbo.tblEmployee, dbo.tblTransaction - Sql only checks the permission of the dbo.ViewDepartment and
-- since the schema of tables used in the view are also the same schema (dbo) Sql won't even check the permissions (This is called Ownership chaining)

-- However if you have a table like Accounting.tblTransaction, then since the schema of the table differs from the schema of the view, Sql actually checks the permission is there for "Accounting" schema

---------

-- Can we add insert/update rows of underlying tables through a view

begin tran
insert into ViewByDepartment(EmployeeNumber, DateofTransaction, Amount) -- we cannot insert/update into multiple underlying tables. All these columns are part of tblTransaction and so it will work
values(901, '2015-01-01', 999.99)
select * from tblTransaction where EmployeeNumber = 901
rollback tran

begin tran
update ViewByDepartment set EmployeeNumber = 902 where EmployeeNumber = 901 -- updating underlying table from a view. Same rule that it doesn't allow multiple base tables updation
select * from tblTransaction where EmployeeNumber = 902
rollback tran

-- If 'With check option' - This is to make sure the data remains visible/same within the view.


-- You cannot delete rows of underlying tables through a view. Because usually the view will be having multiple underlying tables and it will affect all those tables.
-- However if a view is having only one underlying table, then you can delete through the view.

select * from ViewByDepartment -- Run with Display Estimated Execution Plan

-- Creating indexed views

-- Creates a Seek (faster) - Just like an index in a book. Go and seek the row numbers and faster
-- Scan - (much slower) - Scans all records to find the rows matching

-- However there are a lot of rules for creating indexed views (almost to the point that its frustrating to create indexed views)
  -- Not allowed outer joins in the query 
  -- Distinct is not allowed in the query
  -- Count is not allowed in the query
  -- Order by and Top is not allowed in the query

go
alter view dbo.ViewByDepartment with schemabinding as
select D.Department, T.EmployeeNumber, T.DateofTransaction, T.Amount
from dbo.tblDepartment as D 
inner join dbo.tblEmployee as E on D.Department = e.Department -- since there is an outer join. you cannot create index on this view
inner join dbo.tblTransaction as T on T.EmployeeNumber = e.EmployeeNumber
where T.EmployeeNumber between 900 and 1100
go

create unique clustered index inx_viewByDepartment on dbo.ViewByDepartment(EmployeeNumber, Department, Dateoftransaction)
-- check the indexes for this view in Object Explorer

begin tran
drop table tblEmployee
rollback tran -- because tblEmployee is reference in the index of the view, we cannot drop the tblEmployee