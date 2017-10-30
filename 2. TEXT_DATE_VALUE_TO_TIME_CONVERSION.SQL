/******************************
** NAME: TEXT_DATE_VALUE_TO_TIME_CONVERSION.SQL 
** DESC: FUNCTION TO CHECK AND CONVERT DATE VALUES STORED AS TEXT TO A TEXTUAL TIME FORMAT THAT CAN BE INSERTED INTO TIME FIELDS
** AUTH: HTTPS://GITHUB.COM/SANTAKRUSE
** DATE: 30/10/2017
**************************/

CREATE FUNCTION DATE_VALUE_TO_TIME_CONVERSION (@IN AS   NVARCHAR(100)) RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @OUT AS NVARCHAR(50)
        SET @OUT = 
            CASE
                ---NULL  
                WHEN @IN IS NULL THEN NULL

                --MM[]DD[]YYYY & M[]DD[]YYYY
                WHEN @IN LIKE '%[0-1][0-9][ ./-][2-3][0-9][ ./-][0-9][0-9][0-9][0-9]%' THEN CAST('CAUTION US DATE (101)' AS NVARCHAR(50))
                WHEN @IN LIKE '%[0-9][ ./-][2-3][0-9][ ./-][0-9][0-9][0-9][0-9]%' THEN CAST('CAUTION US DATE (101)' AS NVARCHAR(50))

                --00:00:00
                WHEN @IN LIKE '%[0-9][0-9][:][0-9][0-9][:][0-9][0-9]%' THEN CAST(CONVERT(TIME(0), SUBSTRING(@IN, PATINDEX('%[0-9][0-9][:][0-9][0-9][:][0-9][0-9]%', @IN), 8) + CASE WHEN UPPER(@IN) LIKE '%AM%' THEN 'AM' WHEN UPPER(@IN) LIKE '%PM%' THEN 'PM' ELSE '' END, 103) AS NVARCHAR(50))
                                                                                                                    
                --00:00                                                                         
                WHEN @IN LIKE '%[0-9][0-9][:][0-9][0-9]%' THEN CAST(CONVERT(TIME(0), SUBSTRING(@IN, PATINDEX('%[0-9][0-9][:][0-9][0-9]%', @IN), 5) + CASE WHEN UPPER(@IN) LIKE '%AM%' THEN 'AM' WHEN UPPER(@IN) LIKE 'PM' THEN 'PM' END, 103) AS NVARCHAR(50))

                --MMM[]DD[]YYYY & DD[]MMM[]YYYY & YYYY[]MMM[]DD
                WHEN ISDATE(@IN) = 1 AND (UPPER(@IN) LIKE '%JAN%' OR UPPER(@IN) LIKE '%FEB%' OR UPPER(@IN) LIKE '%MAR%' OR UPPER(@IN) LIKE '%APR%' OR UPPER(@IN) LIKE '%MAY%' OR UPPER(@IN) LIKE '%JUN%' OR UPPER(@IN) LIKE '%JUL%' OR UPPER(@IN) LIKE '%AUG%' OR UPPER(@IN) LIKE '%SEP%' OR UPPER(@IN) LIKE '%OCT%' OR UPPER(@IN) LIKE '%NOV%' OR UPPER(@IN) LIKE '%DEC%') AND @IN NOT LIKE '%1905%' AND (@IN LIKE '%[ ./-][0-9][0-9][0-9][0-9]%' OR @IN LIKE '%[0-9][0-9][0-9][0-9][ ./-]%') THEN CAST('00:00:00' AS NVARCHAR(50)) 
            
                --DD[]MM[]YYYY
                WHEN @IN LIKE '%[0-3][0-9][ ./-][0-1][0-9][ ./-][0-9][0-9][0-9][0-9]%' AND ISDATE(RIGHT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][ ./-][0-1][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),10),4) + '/' + RIGHT(LEFT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][ ./-][0-1][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),10),5),2) + '/' + LEFT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][ ./-][0-1][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),10),2)) = 1 THEN CAST('00:00:00' AS NVARCHAR(50))    
                --DD[]M[]YYYY
                WHEN @IN LIKE '%[0-3][0-9][ ./-][0-9][ ./-][0-9][0-9][0-9][0-9]%' AND ISDATE(RIGHT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][ ./-][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),9),4) + '/' + RIGHT(LEFT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][ ./-][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),9),4),1) + '/' + LEFT(SUBSTRING(@IN,PATINDEX('%[0-3][0-9][ ./-][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),9),2)) = 1 THEN CAST('00:00:00' AS NVARCHAR(50))   
                --D[]MM[]YYYY
                WHEN @IN LIKE '%[0-9][ ./-][0-1][0-9][ ./-][0-9][0-9][0-9][0-9]%' AND ISDATE(RIGHT(SUBSTRING(@IN,PATINDEX('%[0-9][ ./-][0-1][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),9),4) + '/' + RIGHT(LEFT(SUBSTRING(@IN,PATINDEX('%[0-9][ ./-][0-1][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),9),4),2) + '/' + LEFT(SUBSTRING(@IN,PATINDEX('%[0-9][ ./-][0-1][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),9),1)) = 1 THEN CAST('00:00:00' AS NVARCHAR(50))   
                --D[]M[]YYYY
                WHEN @IN LIKE '%[0-9][ ./-][0-9][ ./-][0-9][0-9][0-9][0-9]%' AND ISDATE(RIGHT(SUBSTRING(@IN,PATINDEX('%[0-9][ ./-][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),8),4) + '/' + RIGHT(LEFT(SUBSTRING(@IN,PATINDEX('%[0-9][ ./-][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),8),3),1) + LEFT(SUBSTRING(@IN,PATINDEX('%[0-9][ ./-][0-9][ ./-][0-9][0-9][0-9][0-9]%', @IN),8),1)) = 1 THEN CAST('00:00:00' AS NVARCHAR(50))   
              
                --YYYY[]MM[]DD
                WHEN @IN LIKE '%[0-9][0-9][0-9][0-9][ ./-][0-1][0-9][ ./-][0-3][0-9]%' AND ISDATE(SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][ ./-][0-1][0-9][ ./-][0-3][0-9]%', @IN),10)) = 1 THEN CAST('00:00:00' AS NVARCHAR(50))
                --YYYY[]MM[]D
                WHEN @IN LIKE '%[0-9][0-9][0-9][0-9][ ./-][0-1][0-9][ ./-][0-9]%' AND ISDATE(SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][ ./-][0-1][0-9][ ./-][0-9]%', @IN),9)) = 1 THEN CAST('00:00:00' AS NVARCHAR(50))
                --YYYY[]M[]DD
                WHEN @IN LIKE '%[0-9][0-9][0-9][0-9][ ./-][0-9][ ./-][0-3][0-9]%' AND ISDATE(SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][ ./-][0-9][ ./-][0-3][0-9]%', @IN),9)) = 1 THEN CAST('00:00:00' AS NVARCHAR(50))
                --YYYY[]M[]D        
                WHEN @IN LIKE '%[0-9][0-9][0-9][0-9][ ./-][0-9][ ./-][0-9]%' AND ISDATE(SUBSTRING(@IN,PATINDEX('%[0-9][0-9][0-9][0-9][ ./-][0-9][ ./-][0-9]%', @IN),8)) = 1 THEN CAST('00:00:00' AS NVARCHAR(50))
                  
                ---EXCEL DATE
                WHEN LEN(@IN) = 5 AND @IN NOT LIKE '%[^0-9]%' THEN CAST('00:00:00' AS NVARCHAR(50))

            ELSE 'CAUTION TIME NOT FOUND'

            END 
        RETURN  @OUT
    END