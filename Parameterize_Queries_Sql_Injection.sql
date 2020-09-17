Declare @param varchar(1000) = '1' + char(10) + 'select * from [dbo].[tblEmployee]'
Declare @sql varchar(1000) =
 'Select * from [dbo].[tblEmployee] e where e.[EmployeeNumber] = ' + @param;

Exec(@sql) -- Dynamic Query - Prone to Sql Injection

Go

/*
Notice how a user can add a Select query to the parameter and query the Phone records
He could have also done Drop query and dropped a table altogether

The way to stop this Sql injection is to use parameterized query as below
instead of dynamic query
*/

Declare @param varchar(1000) = '1' -- Try the above Sql Injection attack here and it won't work
Exec sys.sp_executesql
@statement = 
 N'Select * from [dbo].[tblEmployee] e where e.[EmployeeNumber] = @empNumber',
@params = N'@empNumber varchar(1000)',
@empNumber = @param

Go