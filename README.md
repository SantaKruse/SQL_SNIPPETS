# SQL_SNIPPETS

## 1. NHS_NUMBER_CHECK
This scalar value function has been developed in alignment with the NHS Number check digit spec [here](http://www.datadictionary.nhs.uk/version2/data_dictionary/data_field_notes/n/nhs_number_de.asp?shownav=0).  It can be used to ensure that NHS Numbers are legitimate.  The function takes a NVARCHAR(100) input value and outputs an array of descriptive messages indicating the problem with the value or that the value is correct.  Once the function has been created it can be called by running the following command where **yourfield** is the database field of the NHS Number that is to be valided: 
```SELECT NHS_NUMBER_CHECK(yourfield) FROM yourtable```

## 2. TEXT_DATE_TO_DATE_CONVERSION
Used to convert date values that are stored as text to formats that can be recognised by the DBMS as date values.  The formats that the function can currently convert are:

21/02/1987 | 21-02-1987 | 21.07.1987 (DDMMYYY)

14/5/1990 | 14-5-1990 | 14.5.1990 (DDMYYYY)

1/04/1965 | 1-04-1965 | 1.04.1965 (DMMYYYY)

6/9/1978 | 6-9-1978 | 6-9-1978 (DMYYYY)

2000/01/30 | 2000-01-30 | 2000.01.30 (YYYYMMDD)

2006/02/4 | 2006-02-4 | 2006.02.4 (YYYYMMD)

2020/6/28 | 2020-6-28 | 2020.06.28 (YYYYMDD)

1980/3/9 | 1980-3-9 | 1980.3.9 (YYYYMD)

42365 (Excel date stored as integer)



