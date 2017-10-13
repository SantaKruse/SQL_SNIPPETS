# SQL_SNIPPETS

## 1. NHS_NUMBER_CHECK
This scalar value function has been developed in alignment with the NHS Number check digit spec [here](http://www.datadictionary.nhs.uk/version2/data_dictionary/data_field_notes/n/nhs_number_de.asp?shownav=0).  It can be used to ensure that NHS Numbers are legitimate.  The function takes a NVARCHAR(100) input value and outputs an array of descriptive messages indicating the problem with the value or that the value is correct.  Once the function has been created it can be called by running the following command where **yourfield** is the database field of the NHS Number that is to be valided: 
```SELECT NHS_NUMBER_CHECK(yourfield) FROM yourtable```

## 2. TEXT_DATE_TO_DATE_CONVERSION

