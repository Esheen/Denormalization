# Denormalization
The original AdventureWorksDW2012 employs a snowflake design in the Product dimension. To resolve this problem, we need to integrate 3 tables (DimProduct, DimProductSubcategory and DimProductCategory) into a single dimension as newDimProduct.  
<br />
Original data storage for 3 dimensional product tables: 19.156+0.008+0.008= 19.172 MB.  
<br />
For building a single dimensional table as ‘newDimProduct’, the data storage space consumes 5.852MB, and yields a 69.48% decrease comparing to the original data space for the snowflake design.(The real data storage space may vary.) Depending on the result, there is not worthwhile to require a complex snowflake query for the database design. The Product dimension is only a small component of the entire database and only 606 rows in the sample dataset. If we put the dataset into reality and encourage snowflake design to every dimension, the storage data space will be huge and significantly reduce the processing speed. 

