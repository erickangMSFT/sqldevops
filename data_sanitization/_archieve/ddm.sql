USE AdventureWorks
Go

ALTER TABLE HumanResources.Employee  
ALTER COLUMN NationalIDNumber ADD MASKED WITH (FUNCTION = 'default()')

ALTER TABLE HumanResources.Employee  
ALTER COLUMN LoginID ADD MASKED WITH (FUNCTION = 'default()')

ALTER TABLE HumanResources.Employee  
ALTER COLUMN BirthDate ADD MASKED WITH (FUNCTION = 'default()')

ALTER TABLE HumanResources.Employee  
ALTER COLUMN MaritalStatus ADD MASKED WITH (FUNCTION = 'default()')

ALTER TABLE Person.EmailAddress
ALTER COLUMN EmailAddress ADD MASKED WITH (FUNCTION = 'email()');  

ALTER TABLE Person.PersonPhone 
ALTER COLUMN PhoneNumber ADD MASKED WITH (FUNCTION = 'partial(5,"XXXXXXX",0)');  
