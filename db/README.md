# Project: AdventureWorks

Say **yo sqlproj** and start developing mssql database.

> This project requires Windows OS to build and publish a database because the build and publish tasks depend on Data-tier Application Framework (DacFx) and it is available on Windows only. 

## Getting Started

First, install [Yeoman](http://yeoman.io) and generator-sqlproj using [npm](https://www.npmjs.com/) (we assume you have pre-installed [node.js](https://nodejs.org/)).

```bash
npm install -g yo
npm install -g generator-sqlproj
```

Create a new folder for your database project and run yo sqlproj.

```bash
mkdir c:\mydatabase
cd c:\mydatabase
yo sqlproj
```

To import an existing database to the project, install [mssql-scripter](https://github.com/Microsoft/sql-xplat-cli) 

```bash
pip install mssql-scripter

```

Then, open ./utils/importdb.ps1 and edit the server, database name to your -S server and -d database. If you are using SQL Login, add -u username and -P password for the connection. Then run it.

```ps
powershell ./utils/importdb.ps1 
```

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
