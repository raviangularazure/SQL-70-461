with tblWithStateRanking as
(select pa.AddressID, pa.City, pa.PostalCode, sp.StateProvinceCode, sp.CountryRegionCode, 
rank() over (partition by sp.StateProvinceID order by pa.AddressID) as StateRank
from [Person].[Address] pa
join [Person].[StateProvince] sp 
on pa.StateProvinceID = sp.StateProvinceID),
tblBusinessUnitAddressChangedAfter2014 as
(Select AddressID from [Person].[BusinessEntityAddress] where ModifiedDate > '2014-01-01')

select t1.* from tblWithStateRanking t1 join tblBusinessUnitAddressChangedAfter2014 t2
on t1.AddressID = t2.AddressID
where t1.StateRank > 100

/*
Use the with keyword everywhere to make it easier to code and also to join multiple temp tables
as in above example.

Notice the with until line no 12 is just one statement altogether and you cannot use that for 
another select statement below line 12
*/

Select Year(ModifiedDate) as TheYear, Month(ModifiedDate) as TheMonth, LineTotal from [Sales].[SalesOrderDetail]
Go

with mySalesData as(
	Select Year(ModifiedDate) as TheYear, Month(ModifiedDate) as TheMonth, LineTotal from [Sales].[SalesOrderDetail])

select * from mySalesData
PIVOT (sum(LineTotal) for TheMonth in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) as myPvt
order by TheYear

/*
Pivot is nothing but summarizing data of a more extensive table. It will always include some sort
of aggregation such as Sum, averages etc.

The above Pivot query is exactly the same as Pivoting the results of query in line no22 using Excel.
Try out it in excel and compare the results with above query.

for TheMonth - This specifies the column to pivot and sum(LineTotal) is the row values for
the pivot column

TheYear will remain as a column since its not mentioned in the Pivot

Notice the Select * from is giving the Pivotted results correctly. 
The With statement keeps the Pivot table simple to understand

If you add extra columns in initial Select it will drastically change the Pivot results
So only keep what is required in the Select

Just like you can Pivot you can also UnPivot 
using the UNPIVOT command

*/


