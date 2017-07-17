/*    ==Scripting Parameters==

    Source Server Version : Version130 (13.0.1601)
    Source Database Engine Edition : Enterprise
    Source Database Engine Type : Standalone

    Target Server Version : Version130
    Target Database Engine Edition : Enterprise
    Target Database Engine Type : Standalone
*/
/****** Object:  StoredProcedure [HumanResources].[uspGetDirectManager]    Script Date: 7/16/17 5:38:15 PM ******/

GO

GO
CREATE PROCEDURE [HumanResources].[uspGetDirectManager]
	@BusinessEntityID int
AS
	SELECT 
	m.[BusinessEntityID]
	,m.[NationalIDNumber]
	,m.[LoginID]
	,m.[OrganizationNode]
	,m.[OrganizationLevel]
    ,m.[Title]
    ,m.[FirstName]
    ,m.[MiddleName]
    ,m.[LastName]
    ,m.[Suffix]
    ,m.[JobTitle]  
    ,m.[PhoneNumber]
    ,m.[PhoneNumberType]
    ,m.[EmailAddress]
    ,m.[EmailPromotion]
    ,m.[AddressLine1]
    ,m.[AddressLine2]
    ,m.[City]
    ,m.[StateProvinceName] 
    ,m.[PostalCode]
    ,m.[CountryRegionName] 
    ,m.[AdditionalContactInfo]
	,m.[DepartmentID]
	,m.[GroupName]
	,m.[DepartmentName]
	FROM [HumanResources].[vEmployee] m 
    INNER JOIN [HumanResources].[vEmployee] e
    ON m.[OrganizationNode] = e.[OrganizationNode].GetAncestor(1)
	where e.BusinessEntityID = @BusinessEntityID
RETURN 0
GO
