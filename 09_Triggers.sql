-- FOR and AFTER are the same. You can use either commands.
-- RIGHT CLICK - Anywhere on a .sql file in SSMS => INSERT SNIPPET => Very Very useful
-- One trigger can call a SQL statement that causes another trigger - This becomes a Nested trigger scenario. Not easy to understand. Avoid triggers in general as it hide business logic

CREATE TRIGGER tr_tblDepartment
    ON [dbo].[tblDepartment]
    AFTER DELETE, INSERT, UPDATE -- Example of AFTER/FOR trigger (In this case AFTER all of the DML statements (Insert, Update, Delete)
    AS
    BEGIN
    SET NOCOUNT ON -- E.g. 5 rows affected message is switched off. You don't want this to happen simply.
		select * from inserted -- what was inserted
		select * from deleted -- what was deleted (when during an update on a row, it inserts a row in "inserted" with changed data, and a row in "deleted" table with old data
    END

Insert into tblDepartment values('Sleep', 'Ravi')


Go
CREATE TRIGGER TriggerName
    ON [dbo].[ViewByDepartment] -- Note this is a View. We are adding a trigger on a view.
    INSTEAD OF DELETE -- In INSTEAD OF trigger you can only choose ONE of the DML statments (Insert OR Update OR Delete)
    AS
    BEGIN
    SET NOCOUNT ON
		Select *, 'ViewByDepartment' from deleted
    END

Delete ViewByDepartment where EmployeeNumber = 950 -- Instead of deleting the rows, the trigger code will run.

-- An Alternate way of setting values for multipl variables
Declare @EmpNum as int;
Declare @DateOfTran as Datetime;
Declare @Amount as smallmoney;

select @EmpNum = 123, @DateOfTran = GetDate(), @Amount = 12222 -- Sets the values of variables
Select @EmpNum, @DateOfTran, @Amount



