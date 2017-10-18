# SQL_SNIPPETS

## 1. NHS_NUMBER_CHECK
This scalar value function has been developed in alignment with the NHS Number check digit spec [here](http://www.datadictionary.nhs.uk/version2/data_dictionary/data_field_notes/n/nhs_number_de.asp?shownav=0).  It can be used to ensure that NHS Numbers are legitimate.  The function takes a NVARCHAR(100) input value and outputs an array of descriptive messages indicating the problem with the value or that the value is correct.  Once the function has been created it can be called by running the following command where **yourfield** is the database field of the NHS Number that is to be validated: 
```SELECT NHS_NUMBER_CHECK(yourfield) FROM yourtable```

## 2. TEXT_DATE_TO_DATE_CONVERSION
This scalar value function can be used to convert date values that are stored as text to formats that can be recognised by the DBMS as date values.  It has been developed to work with textual date values stored in SQL Server Default (all possible combinations of MMM/DD/YYYY), ANSI (YYYY/MM/DD) and European (DD/MM/YYYY) date formats.  The function will recognise values that are seperated by any of the following characters: ```[/] [-] [.] [ ]```  

The function takes an NVARCHAR(100) input value and outputs an ANSI formatted NVARCHAR(100) value if the input can be converted. If the input cannot be converted ```'CAUTION DATE NOT FOUND'``` will be outputted. If an input is recognised as being a US date (MM/DD/YYYY) ```'CAUTION US DATE (101)'``` will be outputted.

If an input value from the year 1905 is found, the function will ignore this value and output ```'CAUTION DATE NOT FOUND'```.  This is because date values from this year are usually integer year values incorrectly stored as dates.

The function can be used as both a date converter and as a method for checking whether a value is already a date.  

Once the function has been created it can be called by running the following command where **yourfield** is the database field of the textual date that is to be converted: 
```SELECT DATE_VALUE_TO_DATE_CONVERSION (yourfield) FROM yourtable```  

The specific formats that the function can convert are:

***YYYYMMMDD:*** 2017/(Jan/January)/09 | 2017-(Jan/January)-09 | 2017.(Jan/January).09 | 2017 (Jan/January) 09 

***YYYYMMMD:*** 2017/(Jan/January)/9 | 2017-(Jan/January)-9 | 2017.(Jan/January).9 | 2017 (Jan/January) 9 

***YYYYDDMMM:*** 2017/09/(Jan/January) | 2017-09-(Jan/January) | 2017.09.(Jan/January) | 2017 09 (Jan/January) 

***YYYYDMMM:*** 2017/9/(Jan/January) | 2017-9-(Jan/January) | 2017.9.(Jan/January) | 2017 9 (Jan/January) 

***MMMDDYYYY:*** (Jan/January)/09/2017 | (Jan/January)-09-2017 | (Jan/January).09.2017 | (Jan/January) 09 2017 

***MMMDYYYY:*** (Jan/January)/9/2017 | (Jan/January)-9-2017 | (Jan/January).9.2017 | (Jan/January) 9 2017 

***DDMMMYYYY:*** 09/(Jan/January)/2017 | 09-(Jan/January)-2017 | 09.(Jan/January).2017 | 09 (Jan/January) 2017 

***DMMMYYYY:*** 9/(Jan/January)/2017 | 9-(Jan/January)-2017 | 9.(Jan/January).2017 | 9 (Jan/January) 2017 

***YYYYMMDD:*** 2017/01/09 | 2017-01-09 | 2017.01.09 | 2017 01 09 

***YYYYMMD:*** 2017/01/9 | 2017-01-9 | 2017.01.9 | 2017 01 9 

***YYYYMDD:*** 2017/1/09 | 2017-1-09 | 2017.1.09 | 2017 1 09 

***YYYYMD:*** 2017/1/9 | 2017-1-9 | 2017.1.9 | 2017 1 9 

***DDMMYYYY:*** 09/01/2017 | 09-01-2017 | 09.01.2017 | 09 01 2017 

***DDMYYYY:*** 09/1/2017 | 09-1-2017 | 09.1.2017 | 09 1 2017 

***DMMYYYY:*** 9/01/2017 | 9-01-2017 | 9.01.2017 | 9 01 2017 

***DMYYYY:*** 9/1/2017 | 9-1-2017 | 9.1.2017 | 9 1 2017 

***Excel date stored as integer:*** 45325

## 3. AUTOMATED_NULL_AND_BLANK_STRING_REMOVAL
This stored procedure is designed to take an NVARCHAR(100) table name as input and autonomously work through each field of the table to remove 'NULL' (NULL stored as text) and '' (empty string).  Individual field names are not required, the procedure loops from the first to the last ordinal field position therefore individual field names are not needed.

Once the procedure has been created it can be called by running the following command where **yourtable** is the database table that is to be processed: 
```EXECUTE AUTOMATED_NULL_AND_BLANK_STRING_REMOVAL @TABLE= **'yourtable'**```



