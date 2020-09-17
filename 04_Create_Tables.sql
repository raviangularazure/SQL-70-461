create table tblEmployee(
EmployeeNumber int not null,
EmployeeFirstName nvarchar(100) not null, -- choose not null columns carefully
EmployeeMiddleName nvarchar(100) null, 
EmployeeLastName nvarchar(100) not null,
EmployeeGovernmentId char(10) null, -- assuming government id will always be a 10 digit value.
DateOfBirth date not null -- choose the correct datatype to reduce storage size.
)

alter table tblEmployee 
add Department nvarchar(500) -- adding a new column

select * from tblEmployee

insert into tblEmployee values(
733, 'Jon','', 'Gage','EU508141V', '1991-11-22', 'Commercial')

insert into [dbo].[tblEmployee] ([EmployeeNumber],[EmployeeFirstName],[EmployeeMiddleName],[EmployeeLastName],[EmployeeGovernmentId]
           ,[Department], [DateOfBirth]) -- Notice we can change ordering of columns if given explicitly.
     values (734, 'Kathleen','M.', 'Funk','AM942860F', 'HR','1983-10-29')

alter table tblEmployee
drop column Department

alter table tblEmployee
add Department nvarchar(100)

alter table tblEmployee alter column Department nvarchar(120) 
-- alter a column without removing and adding it back

alter table tblEmployee alter column Department nvarchar(8) -- error because value in table column has more length

insert into tblEmployee values
(735, 'Dominic','P.', 'Fulton','YD742147K', '1969-09-15', 'Customer Relations'),
(736, 'Janet','M.', 'Frum','NM547395E', '1971-1-25', 'HR') -- inserting multiple records.

-- you could also Edit rows in table and copy row data directly from an excel

select * from tblEmployee where EmployeeLastName != 'Ford' -- Can use <> as well
select * from tblEmployee where EmployeeFirstName like 'm%'
select * from tblEmployee where EmployeeFirstName like '_a%' -- names whose 2nd letter is a. First letter can be anything denoted by an _

select * from tblEmployee where not EmployeeNumber > 900 -- check the not infront of the EmployeeNumber
select * from tblEmployee where EmployeeNumber != 900 -- <> is preferred style. But both can be used

select * from tblEmployee where EmployeeNumber > 900 and EmployeeNumber < 1000
select * from tblEmployee where not (EmployeeNumber > 900 and EmployeeNumber < 1000) -- reverse of the above.

select * from tblEmployee where EmployeeNumber < 900 or EmployeeNumber > 1000
select * from tblEmployee where EmployeeNumber between 900 and 1000

select * from tblEmployee where EmployeeNumber in (900, 901, 902)






