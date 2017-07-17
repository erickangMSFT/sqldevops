/*    ==Scripting Parameters==

    Source Server Version : Version130 (13.0.1601)
    Source Database Engine Edition : Enterprise
    Source Database Engine Type : Standalone

    Target Server Version : Version130
    Target Database Engine Edition : Enterprise
    Target Database Engine Type : Standalone
*/
/****** Object:  StoredProcedure [HumanResources].[uspGetDirectReports]    Script Date: 7/16/17 5:38:15 PM ******/

GO

GO
CREATE PROCEDURE [HumanResources].[uspGetDirectReports]
	@BusinessEntityID int
AS
	DECLARE @hid hierarchyid
	SET @hid = (SELECT Top (1) m.[OrganizationNode] from [HumanResources].[vEmployee] m where m.[BusinessEntityID] = @BusinessEntityID)

	SELECT 
	e.[BusinessEntityID]
	,e.[NationalIDNumber]
	,e.[LoginID]
	,e.[OrganizationNode]
	,e.[OrganizationLevel]
    ,e.[Title]
    ,e.[FirstName]
    ,e.[MiddleName]
    ,e.[LastName]
    ,e.[Suffix]
    ,e.[JobTitle]  
    ,e.[PhoneNumber]
    ,e.[PhoneNumberType]
    ,e.[EmailAddress]
    ,e.[EmailPromotion]
    ,e.[AddressLine1]
    ,e.[AddressLine2]
    ,e.[City]
    ,e.[StateProvinceName] 
    ,e.[PostalCode]
    ,e.[CountryRegionName] 
    ,e.[AdditionalContactInfo]
	,e.[DepartmentID]
	,e.[GroupName]
	,e.[DepartmentName]
    FROM [HumanResources].[vEmployee] e 
    WHERE e.[OrganizationNode].GetAncestor(1) = @hid
RETURN 0
GO
