-- datetime year 1753-01-01 to 9999-12-31 - 8 bytes
-- smalldatetime 1900-01-01 to 2079-06-06 - 4 bytes
-- date 0001-01-01 to 9999-12-31 - 3 bytes
-- time hh:mm:ss [.nnnnnnn] - 3-5 bytes
-- YYYY-MM-DD is the default format stored in db. Think of it as descending order, The Year, Then month and Then the Date

declare @myDate as datetime = '2020-01-015 12:34:56.124'
select @myDate
select 'The date and time is ' + convert(nvarchar(20), @myDate) as myText -- Convert a datetime into a string
select year(@myDate) as theYear, month(@myDate) as theMonth, day(@myDate) as theDay

select getdate() as RightNow
select GETUTCDATE() as UtcRightNow

select datediff(year, '2015-01-01', getdate()) as yearsDifference
select datediff(month, '2015-01-01', getdate()) as monthsDifference

declare @myDateTimeOffset as datetimeoffset = '2015-01-01 00:00:00 +5:30'
select @myDateTimeOffset

-- datetimeoffset stores the timezone to the datetime e.g. India or US timezone

-- culture means language. en-ES means spanish of Spain, es-AR means spanish of Argentina. en-IN means English of India

select format(getdate(), 'dd-MM-yyyy') -- formatting the date to another format than the default YYYY-MM-dd format
select format(getdate(), 'D', 'es-ES') -- show date in Spanish of Spain format








