module SeedData

# OrgChart unittest data seeding

def seed_orgchart_data()

# Seed unittest database in the complex FK relationship.
    # See data/adventureworks/seed_data/_seed_sequence.md for more detail of the data seeding sequence.
    query("SET IDENTITY_INSERT Person.BusinessEntity ON;")
    load_csv('adventureworks/seed_data/seed_person_businessentity.csv', 'Person.BusinessEntity')
    query("SET IDENTITY_INSERT Person.BusinessEntity OFF;")
    
    load_csv('adventureworks/seed_data/seed_person_person.csv', 'Person.Person')
    load_csv('adventureworks/seed_data/seed_humanresources_employee.csv','HumanResources.Employee')
    
    query("SET IDENTITY_INSERT HumanResources.Department ON;")
    load_csv('adventureworks/seed_data/seed_humanresources_department.csv', 'HumanResources.Department')
    query("SET IDENTITY_INSERT HumanResources.Department OFF;")
    
    query("SET IDENTITY_INSERT HumanResources.Shift ON;")
    load_csv('adventureworks/seed_data/seed_humanresources_shift.csv', 'HumanResources.Shift')
    query("SET IDENTITY_INSERT HumanResources.Shift OFF;")

    query("SET IDENTITY_INSERT Person.EmailAddress ON;")
    load_csv('adventureworks/seed_data/seed_person_emailaddress.csv', 'Person.EmailAddress')
    query("SET IDENTITY_INSERT Person.EmailAddress OFF;")

    query("SET IDENTITY_INSERT Person.PhoneNumberType ON;")
    load_csv('adventureworks/seed_data/seed_person_phonenumbertype.csv', 'Person.PhoneNumberType')
    query("SET IDENTITY_INSERT Person.PhoneNumberType OFF;")

    load_csv('adventureworks/seed_data/seed_person_personphone.csv', 'Person.PersonPhone')
    load_csv('adventureworks/seed_data/seed_person_countryregion.csv', 'Person.CountryRegion')
    
    query("SET IDENTITY_INSERT Sales.SalesTerritory ON;")
    load_csv('adventureworks/seed_data/seed_sales_salesterritory.csv', 'Sales.SalesTerritory')
    query("SET IDENTITY_INSERT Sales.SalesTerritory OFF;")

    query("SET IDENTITY_INSERT Person.StateProvince ON;")
    load_csv('adventureworks/seed_data/seed_person_stateprovince.csv', 'Person.StateProvince')
    query("SET IDENTITY_INSERT Person.StateProvince OFF;")

    query("SET IDENTITY_INSERT Person.AddressType ON;")
    load_csv('adventureworks/seed_data/seed_person_addresstype.csv', 'Person.AddressType')
    query("SET IDENTITY_INSERT Person.AddressType OFF;")

    query("SET IDENTITY_INSERT Person.AddressRename ON;")
    load_csv('adventureworks/seed_data/seed_person_addressrename.csv', 'Person.AddressRename')
    query("SET IDENTITY_INSERT Person.AddressRename OFF;")

    load_csv('adventureworks/seed_data/seed_person_businessentityaddress.csv', 'Person.BusinessEntityAddress')
    load_csv('adventureworks/seed_data/seed_humanresources_employeedepartmenthistory.csv', 'HumanResources.EmployeeDepartmentHistory')

end

end

