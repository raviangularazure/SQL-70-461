-- char - ASCII range - 1 byte per character
-- varchar -- ASCII range - 1 byte per character
-- nchar -- Unicode range - 2 bytes per character
-- nvarchar -- Unicode range - 2 bytes per character

-- ASCII - Only English / Western European language
-- Unicode - All languages


declare @myCountry as nvarchar(10) -- try with varchar

set @myCountry = 'Indiaநான்' -- Use N'Indiaநான்' when storing value in a nvarchar data type

select @myCountry as Country, len(@myCountry) as StringLength, DATALENGTH(@myCountry) as StringDataLength

--nchar and nvarchar works exactly the same way. Only difference is it supports multiple languages.

-- Use varchar(8000) instead of varchar(max)

select substring('India', 3, 2) -- Sql is 1 based index unlike C# which is 0 based index

select LTRIM('   India')
select RTRIM(LTRIM('         India A    ')) as Trim

select replace('India is a great country', 'great','Great') 


declare @myVar as int -- Try adding = 0
select @myVar + 2 -- gives null


declare @midName as varchar(100) -- = 'S'
select 'Ravi' + @midName + ' R' -- What's the result. Anything concatenated with null returns null
select 'Ravi' + ISNULL(@midName, '') + ' R'

select 'Ravi' +
case when @midName is null then ''
else ' '  + @midName 
end
+ ' R'

select 'Ravi' + coalesce(@midName, null, '') + ' R' -- coalesce can be used to check multiple values for null and first non-null will apply.


select concat('Ravi ', @midName, ' R')  -- concat is perfect because it returns result even though @midName is null

select 'my number ' + 4567 -- error
select 'my number ' + convert(varchar(20), 4567)
select 'my number ' + cast(4567 as varchar)

select 'my salary is ' + format(222345.6, 'C', 'en-IN')


select [name] + 'A' from sys.all_columns