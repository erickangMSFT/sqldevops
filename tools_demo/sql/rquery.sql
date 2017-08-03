DECLARE @input_query NVARCHAR(MAX); 
	DECLARE @RPlot NVARCHAR(MAX);

DECLARE @StartDate DATE = '20150101';
DECLARE @EndDate DATE = '20151231';

	-- The SQL query representing Input data set.
	-- Get the monthly orders from each Sales between specfic date and time.
	SET @input_query = N'
	SELECT
		DATEFROMPARTS(YEAR(o.[OrderDate]), MONTH(o.[OrderDate]), 1) AS OrderMonth,
		sp.[PreferredName] AS SalesPerson,
		COUNT(DISTINCT o.[OrderID]) AS OrderCount,
		SUM(ol.[Quantity] * ol.[UnitPrice]) AS TotalAmount
	FROM [Sales] .[Orders] o
		INNER JOIN [Sales] .[OrderLines] ol
			ON ol.[OrderID] = o.[OrderID]
		INNER JOIN [Application] .[People] sp
			ON sp.[PersonID] = o.[SalespersonPersonID]
	WHERE sp.[ValidTo] >= GETDATE()
		AND o.[OrderDate] BETWEEN ''' + CAST(@StartDate AS VARCHAR(30)) + ''' AND ''' + CAST(@EndDate AS VARCHAR(30)) + '''
	GROUP BY
		DATEFROMPARTS(YEAR(o.[OrderDate]), MONTH(o.[OrderDate]), 1),
		sp.[PreferredName];'



	SET @RPlot = N'library(ggplot2); 
	image_file = tempfile(); 
	jpeg(filename = image_file, width=600, height=800); 
	plot(mtcars$mpg)

	dev.off(); 
	OutputDataSet <- data.frame(data=readBin(file(image_file,"rb"),what=raw(),n=1e6));'	


	EXEC sp_execute_external_script @language = N'R'
		,@script = @RPlot 
		,@input_data_1 = @input_query
		,@input_data_1_name = N'InputDataSet'
		,@output_data_1_name = N'OutputDataSet' 
		WITH RESULT SETS (( [plot] VARBINARY(MAX)));