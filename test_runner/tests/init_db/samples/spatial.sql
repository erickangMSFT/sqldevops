use WideWorldImporters
go

SELECT TOP 1000 DeliveryLocation.STAsText() as DeliveryLocation
FROM Website.Customers


DECLARE @l geometry;
declare @p geometry;

SET @l = geometry::STGeomFromText('LINESTRING(0 0, 2 3)', 0);  
set @p = geometry::STGeomFromText('POINT (-102.6201979 41.4972022)', 0);
select @l.STAsText() as geo union all
select @p.STAsText();