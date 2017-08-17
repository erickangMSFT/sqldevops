select * from HumanResources.vEmployee

select * from person.BusinessEntity
where BusinessEntityID < 3

select * from HumanResources.Employee
where BusinessEntityID < 3

select * from person.Person
where BusinessEntityID < 3

select * from person.BusinessEntityAddress
where BusinessEntityID < 3

select * from person.AddressRename
where addressID in (249,293)

select * from person.StateProvince
where StateProvinceID = 79

select * from person.CountryRegion
where CountryRegionCode = 'US'

select * from person.PersonPhone
where BusinessEntityID < 3

select * from person.PhoneNumberType
where PhoneNumberTypeID in (1,3)

select * from person.EmailAddress
where BusinessEntityID < 3

select * from HumanResources.EmployeeDepartmentHistory
where BusinessEntityID < 3

select * from HumanResources.Department
where DepartmentID in (1,16)



select * from sales.SalesTerritory
where TerritoryID = 1

select * from HumanResources.EmployeeDepartmentHistory
where BusinessEntityID < 3

select * from HumanResources.Shift
where ShiftID = 1

select * from person.AddressType
where AddressTypeID = 2