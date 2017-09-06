# Project: AdventureWorks
This demo contains state-based database development sample with sqlproj and database source code.

> This project requires Windows OS to build and publish a database because the build and publish tasks depend on Data-tier Application Framework (DacFx) and it is available on Windows only. 


To build and publish the database project to mssql, 
- install [Visual Studio 2017](https://www.visualstudio.com/downloads) inlcuding Data Storage and Process Workload 
- or install [Build Tools for Visual Studio 2017](https://www.visualstudio.com/downloads/#build-tools-for-visual-studio-2017) and [DacFx (Data-tier Application Framework)](https://docs.microsoft.com/en-us/sql/ssdt/download-sql-server-data-tools-ssdt)

Build
```ps
powershell ./utils/build.ps1
```

Publish
```ps
powershell ./utils/publish.ps1
```
To change the publish target server and database, edit ./publish_profiles/localdev.publish.xml file.

```xml
<TargetConnectionString>Data Source=localhost;Integrated Security=True;Connect Timeout=60;Encrypt=False;TrustServerCertificate=True</TargetConnectionString>

```
