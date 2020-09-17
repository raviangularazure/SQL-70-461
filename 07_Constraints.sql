-- Constraints - Rules regarding values allowed in columns of a table
-- Not Null, Unique, Default, Check, Primary Key and Foreign Key - These are all the constraints available

-- 1) Unique constraint - Prevents duplicate values in a column
alter table tblEmployee -- constraints are applied to a table's column
add constraint unqGoverntmentId unique(EmployeeGovernmentId)

-- The above will create a unique key and also a non-clustered index automatically.
-- A column with a unique constraint can have 0 or 1 row with null value.
-- You can also add all these Constraints in the Create table script itself. See examples

select EmployeeGovernmentId, count(*) from tblEmployee
group by EmployeeGovernmentId having count(*) > 1 -- find if there are duplicate entries for EmployeeGovernmentId

alter table tblTransaction
add constraint unqTransaction unique(Amount, DateOfTransaction, EmployeeNumber) -- a combination of unique columns

insert into tblTransaction values(1, '2015-01-01', 900) -- try running it twice

alter table tblTransaction
drop constraint unqTransaction -- drops a constraint by its name (you cannot alter a constraint directly. You can only drop it and create it again)

-- 2) Default constraint - Sets a default value for a column if you don't specify a value when you insert.
alter table tblTransaction add DateOfEntry datetime -- add a new column

alter table tblTransaction
add constraint defDateOfEntry default GetDate() for DateOfEntry -- adding a default constraint
-- You cannot have same name for constraints in different tables in a database. Constraint names need to be unique at the db level.
-- Whenever you want to drop a column, you need to drop its constraints first before dropping the column.


-- 3) Check constraint - Limiting values that are accepted in a single or more than one column in a table.
-- Seems like this is not the right place to put business logic

alter table tblTransaction
add constraint chkAmount check (Amount > -1000 and Amount < 1000) -- add a check constraint that Amount can be only in a range.

update tblTransaction set Amount = 1100 where EmployeeNumber = 900 -- This will now give an error.

alter table tblEmployee with nocheck -- with nocheck will ignore existing rows.
add constraint chkMiddleName check
(replace(EmployeeMiddleName, '.','') = EmployeeMiddleName or EmployeeMiddleName is null) -- allow null values

alter table tblEmployee with nocheck -- with no check will ignore checking existing rows.
add constraint chkDateOfBirth check (DateOfBirth between '1900-01-01' and getdate()) -- date of birth with date range.

update tblEmployee set DateOfBirth = '2021-01-01' where EmployeeNumber = 901 -- Will get constraint error

-- You can skip giving constraint names, and have Sql create an ugly constraint name. This is not recommended. Always give a name for your constraints


-- Primary Key - Unique, non-nullable, clustered index(Physically Sorts the table based on PK)

-- Surrogate key - Its just a int or Guid column which acts as a primary key (not "real" values/data) - This is most common way of creating a PK

alter table tblEmployee
add constraint PK_tblEmployee primary key(EmployeeNumber) -- You can also create a non-clustered index on primary key. But its not advisable

alter table tblEmployee
drop constraint PK_tblEmployee

create table tblEmployee1(
EmployeeNumber int constraint PK_tblEmployee2 primary key identity(1,1), -- identity(1,1) - Automatically adds 1 value to each new row. Starting value is 1
EmployeeName nvarchar(100))

insert into tblEmployee1 values('Ravi'),('Uma')
select * from tblEmployee1
delete from tblEmployee1 -- run insert again and see the values of EmpNumber 
truncate table tblEmployee1 -- run insert again and see the values of EmpNumber

set identity_insert tblEmployee1 on -- this will allow you to specify values for the identity column

insert into tblEmployee1(EmployeeNumber, EmployeeName) values(100, 'Ravi-1'),(101, 'Uma-1')

set identity_insert tblEmployee1 off

drop table tblEmployee1

-- Finding the value of the last identity
select @@IDENTITY -- Returns the last identity used
select SCOPE_IDENTITY() -- Used in functions, procedures. It will return whats last used in that scope

--@@ means its a global variable

select IDENT_CURRENT('dbo.tblEmployee1') -- you can pass any table name and find its last identity value



-- Foreign Key -- Counter part of the primary key. This is a biggie 

-- You can only set a primary key or a unique column as a foreign key in another table.
-- Seek - FK columns are always seeked
-- Scan - If no FK then its a scan (much slower)

-- FK can only have values present in table PK / Unique key. However it can have NULL values
-- So if either the PK/Unique or the FK you insert mismatching values you get FK constraint error. You have few options to avoid FK constraint error. 
-- no action -- Error will come. This is what happens by default.
-- cascade -- cascade the PK value to FK
-- set null -- Set FK as null
-- set default -- Set FK as a default value (this default needs to be present in PK)

alter table tblTransaction
add constraint FK_tblTransaction_EmployeeNumber foreign key (EmployeeNumber) -- Note  the naming convention
references tblEmployee(EmployeeNumber) -- this is the PK and its table

-- on update cascade -- cascade the update on PK to the FK. 
-- on update set null -- set null
-- on update set default -- sets the FK columns default value (default constraint must first be set for that column)

-- set each one of the above and try the below
begin tran
select * from tblTransaction where EmployeeNumber = 900
Update tblEmployee set EmployeeNumber = 9000 where EmployeeNumber = 900
select * from tblTransaction where EmployeeNumber = 900
select * from tblTransaction where EmployeeNumber = 9000
rollback tran

alter table tblTransaction
drop constraint FK_tblTransaction_EmployeeNumber

-- on delete cascade - deletes the records in FK table. Its pretty dangerous.
-- on delete set null - does not delete the records but sets the FK to null. Probably a better option. Alteast it keeps the records
-- on delete set default - does not dlete the records, but sets the FK column's default value (default constraint must first be set for that column)

-- Your FK can span multiple columns. Although its very rare such a FK

-- In general all these constraints discussed above, can be added during table create or alter table add constraint
-- If you want to modify a constraint you alter table drop constraint and add back with changes


