# SQL_SNIPPETS

## 1. NHS_NUMBER_CHECK
This scalar value function has been developed in alignment with the NHS Number check digit spec [here](http://www.datadictionary.nhs.uk/version2/data_dictionary/data_field_notes/n/nhs_number_de.asp?shownav=0).  It can be used to ensure that NHS Numbers are legitimate.  The function takes a NVARCHAR(100) input value and outputs an array of descriptive messages indicating the problem with the value or that the value is correct.  Once the function has been created it can be called by running the following command where **yourfield** is the database field of the NHS Number that is to be valided: 
```SELECT NHS_NUMBER_CHECK(yourfield) FROM yourtable```

## 2. TEXT_DATE_TO_DATE_CONVERSION
Used to convert date values that are stored as text to formats that can be recognised by the DBMS as date values.  The formats that the function can currently convert are:

***YYYYDDMMM:*** 2017/09/(Jan/January) | 2017-09-(Jan/January) | 2017.09.(Jan/January) | 2017 09 (Jan/January) 

***YYYYDMMM:*** 2017/9/(Jan/January) | 2017-9-(Jan/January) | 2017.9.(Jan/January) | 2017 9 (Jan/January) 

***YYYYMMMDD:*** 2017/(Jan/January)/09 | 2017-(Jan/January)-09 | 2017.(Jan/January).09 | 2017 (Jan/January) 09 

***YYYYMMMD:*** 2017/(Jan/January)/9 | 2017-(Jan/January)-9 | 2017.(Jan/January).9 | 2017 (Jan/January) 9 

***DDMMMYYYY:*** 09/(Jan/January)/2017 | 09-(Jan/January)-2017 | 09.(Jan/January).2017 | 09 (Jan/January) 2017 

***DMMMYYYY:*** 9/(Jan/January)/2017 | 9-(Jan/January)-2017 | 9.(Jan/January).2017 | 9 (Jan/January) 2017 

***MMMDDYYYY:*** (Jan/January)/09/2017 | (Jan/January)-09-2017 | (Jan/January).09.2017 | (Jan/January) 09 2017 

***MMMDYYYY:*** (Jan/January)/9/2017 | (Jan/January)-9-2017 | (Jan/January).9.2017 | (Jan/January) 9 2017 

***DDMMYYYY:*** 09/01/2017 | 09-01-2017 | 09.01.2017 | 09 01 2017 

***DDMYYYY:*** 09/1/2017 | 09-1-2017 | 09.1.2017 | 09 1 2017 

***DMMYYYY:*** 9/01/2017 | 9-01-2017 | 9.01.2017 | 9 01 2017 

***DMYYYY:*** 9/1/2017 | 9-1-2017 | 9.1.2017 | 9 1 2017 

***YYYYMMDD:*** 2017/01/09 | 2017-01-09 | 2017.01.09 | 2017 01 09 

***YYYYMMD:*** 2017/01/9 | 2017-01-9 | 2017.01.9 | 2017 01 9 

***YYYYMDD:*** 2017/1/09 | 2017-1-09 | 2017.1.09 | 2017 1 09 

***YYYYMD:*** 2017/1/9 | 2017-1-9 | 2017.1.9 | 2017 1 9 

***42365:*** (Excel date stored as integer)



