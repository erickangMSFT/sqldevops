create table #ls (name varchar(255), LogSize real, LogSpaceUsed real, Status int) 

insert #ls exec ('dbcc sqlperf(logspace)') 

declare @name varchar(255), @sql varchar(1000); 

select d.name, 
   ls.LogSize, ls.LogSpaceUsed
into #dbs1 
from master.sys.databases as d 
join #ls as ls
   on d.name = ls.name 


create table #dbsize1 (
   fileid int,
   filegroup int,
   TotalExtents bigint,
   UsedExtents bigint,
   dbname varchar(255),
   FileName varchar(255)); 

declare c1 cursor for select name from #dbs1; 
open c1; 

fetch next from c1 into @name; 
while @@fetch_status = 0 
begin 
    set @sql = 'use [' + @name + ']; DBCC SHOWFILESTATS WITH NO_INFOMSGS;' 
    insert #dbsize1 exec(@sql); 
   update #dbs1 
   set Size = (select sum(TotalExtents) / 16 from #dbsize1),
      Used = (select sum(UsedExtents) / 16 from #dbsize1) 
   where name = @name; 
   truncate table #dbsize1; 
   fetch next from c1 into @name; 
end; 
close c1; 
deallocate c1; 

select * from #dbs1 
order by name; 

drop table #dbsize1; 
drop table #dbs1;
drop table #ls;