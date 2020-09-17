
-- Updating an entire table from one Db to another Db (Where the Primary Key Ids are different between the dbs)
SELECT 'UPDATE SystemFieldTemplate SET SystemFieldTemplateId=''' + convert(nvarchar(50), SystemFieldTemplateId) + ''''
    + ' , Prompt =''' + Prompt +'''' + ',Value =''' + Value + '''
WHERE Field = '''+ Field + '''' + ' AND SystemTypeId =' + convert(nvarchar(50),SystemTypeId)
FROM SystemFieldTemplate 