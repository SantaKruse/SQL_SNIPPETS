# SQL_SNIPPETS

1. NHS_NUMBER_CHECK - This scalar value function has been developed in alignment with the NHS Number check digit spec [here](http://www.datadictionary.nhs.uk/version2/data_dictionary/data_field_notes/n/nhs_number_de.asp?shownav=0).  It can be used to ensure that NHS Numbers are legitimate.  The function takes a nvarchar(100) input value and outputs an array of descriptive error messages and a success message. 
