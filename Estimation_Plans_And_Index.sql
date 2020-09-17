Set Statistics IO On

Set Statistics Time On

/*

Write your query here

*/


Set Statistics IO Off

Set Statistics Time Off


/*
Click on "Display Estimated Execution Plan" in toolbar
"Actual Execution Plan" is even better - It gives actual plan Sql took to run.

Think of each individual box in Execution Plan as a Microservice that runs and passes 
the data to the next microservice from Right to left.
Each individual microservice will have % of the total cost of 100% for running that particular query.

Set Statistics IO On - This will give you the IO details such as logical reads (no of pages read)
Set Statistics Time On - This will give you the CPU time for the query to run. This is very
important so you can find if CPU time is taking a lot.

In Execution Plan, if you see clustered index scan or seek (better) and 
Merge Joins (2 large tables) or Nested Loop (1 small and 1 large table) then you are doing good.
Sorting is always bad. Just take a look at the % of total cost in execution plan

Just think of a table as a bunch of printed out pages of row data
Scan - Scan the entire table to fetch data - Slower
Seek - Directly go and find the data (indexed) - Really quick

B-Tree - Also called a Balanced Tree. This speeds up retrieval of data
Indexes are used to create the B-Tree

Clustered Index - Table is physically sorted by the clustered index key(s).
Clustered index will have a copy of only the index field(s). So a clustered index
scan is faster when doing Select * from tablename, compared to no clustered index for Select * from

NonClustered Index - Also creates a copy of only the index field(s)
So it does a Seek if your Select fields as only those columns as in the NonClustered index.
Look at your Select and Where clauses and create NonClustered indexes

NonClustered indexes are basically copies and they need to be updated for each Create, Update and Delete
So don't overdo.

Filtered Index - Index definition which has a where clause

Include keyword in Index - Allows to add additional index fields at the leaf level of the B-Tree
The B-Tree has three levels 
	Root level (Usually the ids)
	Intermediate level (Usually the ids)
	Leaf level (Actual fields stored for index)

E.g. of Include

create nonclustered index ix_firstname_lastname
on [Person].[Person]([ModifiedDate])
include([FirstName],[LastName])

Select FirstName, LastName, ModifiedDate from [Person].[Person] 
where ModifiedDate between '2000-01-01' and '2020-01-01'

drop index ix_firstname_lastname
on [Person].[Person]

-----------------------------
Different types of Joins

Hash Join - This will be the match used, when both the below matches cannot be done
This is the worst join of the three

Nested Loop Join - One smaller table's rows joined to larger table's rows

Merge Join - Merging 2 large tables, sorted on what you are joining

SARG - Search Argument - Its nothing but using of Where clause in which the field is an index
Makes the query run much faster

*/