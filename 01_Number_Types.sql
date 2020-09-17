-- 255 tinyint
-- 32467 smallint
-- int - larger range
-- big int - much larger range

-- use the proper int data type based on your scenario

declare @myvar as smallint = 10.12 -- decimals are removed in int types
select @myvar

-- decimal type - as decimal(7,2) - 7 is total no of digits including digits after decimal, 2 is no of digits after decimal
-- numeric type - both numeric and decimal are essentially both the same. Difference is in storage size bytes

declare @myvar2 as decimal(9,3) = 10126.3455
select @myvar2

declare @myvar3 as numeric(7,2) = 10126.34
select @myvar3

-- smallmoney
-- money - difference is size number range again.

declare @myvar4 as money = 10000
select @myvar4

-- float
-- real - Its best advised not to use float or real explicitly

-------------
declare @myvar5 as int = 4
select Power(@myvar5,3)
select square(@myvar5)

select Power(@myvar5, 0.5)
Select SQRT(@myvar5)

-- floor, cieling - floor rounds to down to nearest number and cieling rounds to up

Select rand(29586) -- Generates a random number

-- there are many functions. You can check the documentation as required