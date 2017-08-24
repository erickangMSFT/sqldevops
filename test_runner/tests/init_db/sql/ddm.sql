USE WideWorldImporters
Go

ALTER TABLE Application.People
ALTER COLUMN EmailAddress ADD MASKED WITH (FUNCTION = 'email()');  

ALTER TABLE Application.People
ALTER COLUMN FaxNumber ADD MASKED WITH (FUNCTION = 'default()');  

ALTER TABLE Application.People
ALTER COLUMN PhoneNumber ADD MASKED WITH (FUNCTION = 'default()');  
