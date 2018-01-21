# SQL_SNIPPETS

## 1. NHS Number Check
This scalar value function has been developed in alignment with the NHS Number check digit spec [here](http://www.datadictionary.nhs.uk/version2/data_dictionary/data_field_notes/n/nhs_number_de.asp?shownav=0).  It can be used to ensure that NHS Numbers are legitimate.  The function takes a NVARCHAR(100) input value and outputs an array of descriptive messages indicating the problem with the value or that the value is correct.  Once the function has been created it can be called by running the following command where **yourfield** is the database field of the NHS Number that is to be validated: 
```SELECT NHS_NUMBER_CHECK(yourfield) FROM yourtable```

## 2.1. Text date to date conversion
This scalar value function can be used to convert date values that are stored as text to formats that can be recognised by the DBMS as date values.  It has been developed to work with textual date and datetime values stored in SQL Server Default (all possible combinations of MON/DD/YYYY), ANSI (YYYY/MM/DD) and European (DD/MM/YYYY) date formats.  The function can also process dates stored as integers (for example the raw date format used in MS Excel).  The function will recognise values that are seperated by any of the following characters: ```[/] [-] [.] [ ]```  

The function takes an NVARCHAR(100) input value and outputs an ANSI formatted NVARCHAR(100) value if the input can be converted. If the input cannot be converted ```'CAUTION DATE NOT FOUND'``` will be outputted. If an input is recognised as being a US date (MM/DD/YYYY) ```'CAUTION US DATE (101)'``` will be outputted.

If a valid date input value from the year 1905 is found, the function will ignore this value and output ```'CAUTION DATE NOT FOUND'```.  This is because date values from this year are usually integer year values incorrectly stored as dates.

The function can be used as both a date converter and as a method for checking whether a value is a valid date.  

Once the function has been created it can be called by running the following command where **yourfield** is the database field of the textual date that is to be converted: 
```SELECT DATE_VALUE_TO_DATE_CONVERSION (yourfield) FROM yourtable```  

The specific formats that the function can convert are:

***YYYYMONDD:*** 2017/(Jan/January)/09 | 2017-(Jan/January)-09 | 2017.(Jan/January).09 | 2017 (Jan/January) 09 

***YYYYMOND:*** 2017/(Jan/January)/9 | 2017-(Jan/January)-9 | 2017.(Jan/January).9 | 2017 (Jan/January) 9 

***YYYYDDMON:*** 2017/09/(Jan/January) | 2017-09-(Jan/January) | 2017.09.(Jan/January) | 2017 09 (Jan/January) 

***YYYYDMON:*** 2017/9/(Jan/January) | 2017-9-(Jan/January) | 2017.9.(Jan/January) | 2017 9 (Jan/January) 

***MONDDYYYY:*** (Jan/January)/09/2017 | (Jan/January)-09-2017 | (Jan/January).09.2017 | (Jan/January) 09 2017 

***MONDYYYY:*** (Jan/January)/9/2017 | (Jan/January)-9-2017 | (Jan/January).9.2017 | (Jan/January) 9 2017 

***DDMONYYYY:*** 09/(Jan/January)/2017 | 09-(Jan/January)-2017 | 09.(Jan/January).2017 | 09 (Jan/January) 2017 

***DMONYYYY:*** 9/(Jan/January)/2017 | 9-(Jan/January)-2017 | 9.(Jan/January).2017 | 9 (Jan/January) 2017 

***YYYYMMDD:*** 2017/01/09 | 2017-01-09 | 2017.01.09 | 2017 01 09 

***YYYYMMD:*** 2017/01/9 | 2017-01-9 | 2017.01.9 | 2017 01 9 

***YYYYMDD:*** 2017/1/09 | 2017-1-09 | 2017.1.09 | 2017 1 09 

***YYYYMD:*** 2017/1/9 | 2017-1-9 | 2017.1.9 | 2017 1 9 

***DDMMYYYY:*** 09/01/2017 | 09-01-2017 | 09.01.2017 | 09 01 2017 

***DDMYYYY:*** 09/1/2017 | 09-1-2017 | 09.1.2017 | 09 1 2017 

***DMMYYYY:*** 9/01/2017 | 9-01-2017 | 9.01.2017 | 9 01 2017 

***DMYYYY:*** 9/1/2017 | 9-1-2017 | 9.1.2017 | 9 1 2017 

***Excel date stored as integer:*** 45325

## 2.2. Text date to time conversion
This scalar value function can be used to convert date and time values that are stored as text to formats that can be recognised by the DBMS as time values.  It has been developed to work with textual datetime, date and time values stored in SQL Server Default (all possible combinations of MON/DD/YYYY), ANSI (YYYY/MM/DD) and European (DD/MM/YYYY) date formats.    The function can also process dates stored as integers (for example the raw date format used in MS Excel).  The function will recognise values that are seperated by any of the following characters: ```[/] [-] [.] [ ]```  

The function takes an NVARCHAR(100) input value and outputs an 24 hour format	(HH:mm:ss) NVARCHAR(100) value if the input can be converted. If the input cannot be converted to a valid time value but a valid date is found, the function will output 00:00:00. If the input cannot be converted ```'CAUTION TIME NOT FOUND'``` will be outputted. If an input is recognised as being a US date (MM/DD/YYYY) ```'CAUTION US DATE (101)'``` will be outputted.

If a valid date input value from the year 1905 is found, the function will ignore this value and output ```'CAUTION TIME NOT FOUND'```.  This is because date values from this year are usually integer year values incorrectly stored as dates.

The function can be used as both a time converter and as a method for checking whether a value is a valid time.  

Once the function has been created it can be called by running the following command where **yourfield** is the database field of the textual date that is to be converted: 
```SELECT DATE_VALUE_TO_TIME_CONVERSION (yourfield) FROM yourtable```  

The specific formats that the function can convert are:

***All date formats outlined in the 2.1. Text date to date conversion function***

***HH:MM:SS:*** 13:21:59

***HH:MM:SS AM/PM:*** 11:13:40 AM

***HH:MM AM/PM:*** 09:21 PM

***HH:MM:*** 21:41

## 2.3. Text date to year conversion
This scalar value function can be used to convert date values that are stored as text to four digit year formats.  It has been developed to work with textual datetime and date values stored in SQL Server Default (all possible combinations of MON/DD/YYYY), ANSI (YYYY/MM/DD) and European (DD/MM/YYYY) date formats.  The function can also process dates stored as integers (for example the raw date format used in MS Excel).  The function will recognise values that are seperated by any of the following characters: ```[/] [-] [.] [ ]```  

The function takes an NVARCHAR(100) input value and outputs a four digit year NVARCHAR(100) value if the input can be converted. If the input cannot be converted ```'CAUTION YEAR NOT FOUND'``` will be outputted. If an input is recognised as being a US date (MM/DD/YYYY) ```'CAUTION US DATE (101)'``` will be outputted.

If a valid date input value from the year 1905 is found (date values from this year are usually integer year values incorrectly stored as dates), the function will convert the value to a year format by calculating the day difference from the date 1899-12-30 and the input value.

The function can be used as both a year converter and as a method for checking whether a value is a valid year.  

Once the function has been created it can be called by running the following command where **yourfield** is the database field of the textual date that is to be converted: 
```SELECT DATE_VALUE_TO_YEAR_CONVERSION (yourfield) FROM yourtable```  

The specific formats that the function can convert are:

***All date formats outlined in the 2.1. Text date to date conversion function***

***MMMYY:*** Jan/January/17 | Jan/January-17 | Jan/January.17 | Jan/January 17

***YYYY:*** 2017

***YYYY:*** /2017 | -2017 | .2017 |  2017

***YYYY:*** 2017/ | 2017- | 2017. | 2017 

## 3. Automated NULL and empty string removal
This stored procedure is designed to take an NVARCHAR(100) table name as input and autonomously work through each field of the table to remove 'NULL' (NULL stored as text) and '' (empty strings).  You do not declare the individual field names that require processing, the procedure automatically loops from the first to the last ordinal field position.

Once the procedure has been created it can be called by running the following command where **yourtable** is the database table that is to be processed: 
```EXECUTE AUTOMATED_NULL_AND_BLANK_STRING_REMOVAL @TABLE= 'yourtable'``` 



