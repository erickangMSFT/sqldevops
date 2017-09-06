SELECT
    c.CustomerID, 
    c.CustomerName, 
    c.CustomerCategoryName CustomerCategory, 
    c.PrimaryContact, 
    c.AlternateContact, 
    c.PhoneNumber,
    c.WebsiteURL
FROM Website.Customers c