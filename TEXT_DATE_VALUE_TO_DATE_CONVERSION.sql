/******************************
** Name: TEXT_DATE_VALUE_TO_DATE_CONVERSION.sql   
** Desc: Function to check and convert date values stored as text to a textual date format that can be inserted into date fields
** Auth: https://github.com/SantaKruse
** Date: 13/10/2017
**************************/
CREATE FUNCTION	DATE_VALUE_TO_DATE_CONVERSION (@IN AS	NVARCHAR(100)) RETURNS NVARCHAR(100)
AS
	BEGIN
		DECLARE @OUT AS	NVARCHAR(50)
		SET @OUT = 
			CASE
				--NULL		
				WHEN @IN IS NULL THEN NULL
				--MM[]DD[]YYYY & M[]DD[]YYYY
				WHEN PATINDEX('%[0-1][0-9][./-][2-3][0-9][./-][0-9][0-9][0-9][0-9]%', @IN) > 0 THEN CAST('CAUTION US DATE (101)' AS NVARCHAR(50))
				WHEN PATINDEX('%[0-9][./-][2-3][0-9][./-][0-9][0-9][0-9][0-9]%', @IN) > 0 THEN CAST('CAUTION US DATE (101)'	AS NVARCHAR(50))
				--MMM[]DD[]YYYY & DD[]MMM[]YYYY	& YYYY[]MMM[]DD
				WHEN ISDATE(@IN) = 1 AND (UPPER(@IN) LIKE '%JAN%' OR UPPER(@IN) LIKE '%FEB%' OR UPPER(@IN) LIKE '%MAR%' OR UPPER(@IN) LIKE '%APR%' OR UPPER(@IN) LIKE '%MAY%' OR UPPER(@IN) LIKE '%JUN%' OR UPPER(@IN) LIKE '%JUL%' OR UPPER(@IN) LIKE '%AUG%' OR UPPER(@IN) LIKE '%SEP%' OR UPPER(@IN) LIKE '%OCT%' OR UPPER(@IN) LIKE '%NOV%' OR UPPER(@IN) LIKE '%DEC%') AND @IN NOT LIKE '%1905%' AND (PATINDEX('%[ ./-][0-9][0-9][0-9][0-9]%', @IN) > 0 OR PATINDEX('%[0-9][0-9][0-9][0-9][ ./-]%', @IN) > 0) THEN CAST(CONVERT(DATE, @IN, 103) AS NVARCHAR(50))
				--DD[]MM[]YYYY
				WHEN PATINDEX('%[0-3][0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN) > 0 AND ISDATE(RIGHT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),10),4) + '/' + RIGHT(LEFT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),10),5),2) + '/' + LEFT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),10),2)) = 1 THEN CASE WHEN DATEPART(YYYY,CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),10), 103)) <> 1905 THEN CAST(CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),10), 103) AS NVARCHAR(50)) END		
				--DD[]M[]YYYY
				WHEN PATINDEX('%[0-3][0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN) > 0 AND ISDATE(RIGHT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9),4) + '/' + RIGHT(LEFT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9),4),1) + '/' + LEFT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9),2)) = 1 THEN CASE WHEN DATEPART(YYYY,CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9), 103)) <> 1905 THEN CAST(CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-3][0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9), 103) AS NVARCHAR(50)) END		
				--D[]MM[]YYYY
				WHEN PATINDEX('%[0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN) > 0 AND ISDATE(RIGHT(SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9),4) + '/' + RIGHT(LEFT(SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9),4),2) + '/' + LEFT(SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9),1)) = 1 THEN CASE WHEN DATEPART(YYYY,CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9), 103)) <> 1905 THEN CAST(CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-1][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),9), 103) AS NVARCHAR(50)) END		
				--D[]M[]YYYY
				WHEN PATINDEX('%[0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN) > 0 AND ISDATE(RIGHT(SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),8),4) + '/' + RIGHT(LEFT(SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),8),3),1) + LEFT(SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),8),1)) = 1 THEN CASE WHEN DATEPART(YYYY,CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),8), 103)) <> 1905 THEN CAST(CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][./-][0-9][./-][0-9][0-9][0-9][0-9]%', @IN),8), 103) AS NVARCHAR(50)) END		
				--YYYY[]MM[]DD
				WHEN PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-1][0-9][./-][0-3][0-9]%', @IN) > 0 AND ISDATE(SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-1][0-9][./-][0-3][0-9]%', @IN),10)) = 1 THEN CASE WHEN DATEPART(YYYY,CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-1][0-9][./-][0-3][0-9]%', @IN),10), 102)) <> 1905 THEN CAST(CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-1][0-9][./-][0-3][0-9]%', @IN),10), 102) AS NVARCHAR(50)) END
				--YYYY[]MM[]D
				WHEN PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-1][0-9][./-][0-9]%', @IN) > 0 AND ISDATE(SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-1][0-9][./-][0-9]%', @IN),9)) = 1 THEN CASE WHEN DATEPART(YYYY,CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-1][0-9][./-][0-9]%', @IN),9), 102)) <> 1905 THEN CAST(CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-1][0-9][./-][0-9]%', @IN),9), 102) AS NVARCHAR(50)) END
				--YYYY[]M[]DD
				WHEN PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-9][./-][0-3][0-9]%', @IN) > 0 AND ISDATE(SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-9][./-][0-3][0-9]%', @IN),9)) = 1 THEN CASE WHEN DATEPART(YYYY,CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-9][./-][0-3][0-9]%', @IN),9), 102)) <> 1905 THEN CAST(CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-9][./-][0-3][0-9]%', @IN),9), 102) AS NVARCHAR(50)) END
				--YYYY[]M[]D				
				WHEN PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-9][./-][0-9]%', @IN) > 0 AND ISDATE(SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-9][./-][0-9]%', @IN),8)) = 1 THEN CASE WHEN DATEPART(YYYY,CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-9][./-][0-9]%', @IN),8), 102)) <> 1905 THEN CAST(CONVERT(DATE, SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][./-][0-9][./-][0-9]%', @IN),8), 102) AS NVARCHAR(50)) END		
				---EXCEL DATE
				WHEN LEN(@IN) = 5 AND PATINDEX('%[^0-9]%', @IN) = 0 THEN CAST(DATEADD(D, CAST(@IN AS INT), '1899-12-30') AS NVARCHAR(50))		
			ELSE 'CAUTION DATE NOT FOUND'
			END 
		RETURN @OUT
	END






