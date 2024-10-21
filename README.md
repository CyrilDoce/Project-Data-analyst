# Project-Data-analyst

# Cleaning using Excel:

# Check for duplicated values
Highlight the entire table and hover over data at the top and click "remove duplicates" under the data tools 

# Product_name 

It is too vague to denote what is actually the product we are looking for each row therefore I will leave it alone

# Category 

There are unnecessary details regarding the products category field such as the sub categories of each parent category.
For example computers&accessories -> accessories&peripherals -> cables&accessories etc. 
To simplify there only needs to be the first category specified within the "category" field.
1) To do this I would hover over the "find&select" icon in the top right and click "find"
2) There will be two options, click on "replace and insert "|*" to highlight characters after the "|" value.
3) Finally replace with " " to filter out any values

# Discounted_price and actual_price

There seems to be a formatting error upon downloading the dataset with the following characters "â‚¹" appearing
before the price. 
1) Highlight both columns using CTRL and clicking over the "D" and "E" columns at the top of the dataset.
2) Using the same process I will use the replace feature under "find&select" to remove values "â‚¹" 
3) This time replacing only the value "â‚¹" and nothing after it

# discount_percentage

To check if the discount percentage accurately applies to the "actual_price" field to create "discounted_price"
I will insert a new field "Check_discounted_price" in order to see if they accurately match

1) Create a new field by right clicking the G field and clicking insert
2) Click on the f2 cell and create a formula "=E2-(E2*G2)" 
3) Click on the formula and drag down 
4) Click on the "F" column and CTRL + C
5) Click on the paste options within "home" and "paste as value"

This is to ensure the entire column is formatted as a value and not a formula of the actual price column

user_name and review_id 
This column is slightly complicated as there are multiple user_names and review_id values within their respective
column. As a result this isn't a normalised data set that can be used for later querying within SQL, therefore
I have to split the usernames within each of their own product ids and review_id rows.

# Data transformation using Power query:

By using excels power query I will break down the rows within the columns such that they are all individually part of their own respective product id and normalised. Right now there are multiple values within user_name, user_id and review_id.

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%201.png?raw=true)

Next I will remove unnecessary columns that don't require breaking down or transforming as they may cause the data transformation to process slower, therefore columns other than the product_id, user_name, user_id or review_id will be removed and added later on.

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%202.png)
![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%203.png)

Next I will split the user_name, user_id and review_id columns via delimiter (delimiters are characters that separate words e.g , or . ) which will be the commas in this instance.

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20Transform%204.png)

This will lead into multiple instances of user_id, review_id and user_name columns with their respective values

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%205.png)
![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%206.png)
![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%207.png)
/
# How unpivotting works

Within a table are attributes (columns) and values (multiple rows). Unpivotting allows for the attributes to be stored in a singular column with the values also stored in a singular column corresponding to eachother. This may be useful in instances where there are too many of similar columns being referenced in a table, which may be better to store as rows. For example, user_id.1, user_id.2,user_id.3 etc would be better stored as one singular column: user_id. 

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/Explain%20how%20unpivotting%20work.png)
(insert explain 1)

In this instance I will have to unpivot these columns into one singular column with multiple rows known as the attributes, simultaneously having the "values" being held in another singular column. This distinction allows each product to have user_names, user_ids and review_ids correspond to the values whilst not being mashed together as an array in one column. As a result, it is normalised.

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/Explain%20how%20unpivotting%20work%202.png)

(insert explain 2 )

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%208.png)

(insert snippet PQ transformation 8)

Within the attribute column we have user_ids, user_names and review_ids for each product with a number assigned to each. Each number represents the columns that contain values corresponding to each product id.

# How group by works
This feature is similar to the group by statement used in sql where values that match a group are "aggregated" together using count, sum,avg etc. Aggregations calculate across multiple rows based on groups in order to output one value for that group. In this instance I am not trying to "aggregate" in order to find a singular value, but to group rows within a nested table.

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/How%20to%20group%20by.png)
(insert group by snipp )

Using the split by delimiter once more I need to separate the numbers to a distinct column named "index". This instance I will split via "." instead of ",".

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%209.png)
(insert snippet PQ transformation 9)
->
![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%2010.png)
(insert snippet PQ transformation 10)

Next, I will use the group by feature within excel to group every unique combination of product_id and the index, this will allow me to group review_id, user_id and user_name into their respective group number within their respective product_id. 

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%2011.png)
(insert snippet PQ transformation 11)


The values would be stored within a nested table.

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%2012.png)
(insert snippet PQ transformation 12)

Next, I will need to expand the table to show the "attributes" and "values" of the nested tables. These contain every column combination containing the values that go under each column

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%2013.png)
(insert snippet PQ transformation 13)

# How the pivot works
Pivotting enables the row values within a column to be transformed into multiple columns to increase readability. It is the opposite of unpivotting where rows within multiple columns are transformed into singular columns alongside the values. 

Finally, using the pivot feature I need to transform the values under the "attribute" column to be stored as the final columns having the "values" column remain .

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%2014.png)
(insert snippet PQ transformation 14)

This is to ensure that values such as user_id, user_name and review_id are "fields"/ "columns" that can be identified by SQL later on, simultaneously having every value corresponding within each column remain such as 
"Manav" as username . 

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/PQ%20transform%2015.png)
(insert snippet PQ transformation 15)


# Cleaning using SQL server:

After importing the data from power query I must further clean the data. For instance, I need to remove any rows that have null values within the user_id, user_name and review_id column as they are too vague to be considered useful for later analysis.

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/CHECK%20DUPLICATED%20data%20within%20clean%20table.png)
(insert snippet check duplicated data ) 

In addition I need to remove any duplicated data within sql 

Next I need to re-add the columns that were deleted during the data transformation phase within power query. Therefore, I need to use a join on the product_id for the clean table and the power query table. These columns include:
product_name,
category,
discounted_price, 
actual_price, 
check_discounted_price, 
discount_percentagerating, 
rating_count

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/JOIN%20CLEAN%20AND%20PQ%201.png)
![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/JOIN%20CLEAN%20AND%20PQ%202.png)
(insert snippet Join pq and clean 1&2)

# Create the final table 

Finally, I need to create the table with both joins and export the table in order to use it for data analysis within excel. 

# Data analysis using excel:

After importing the data there seems to be erroneous data for the pricing of the products. For example for a usb charger it is priced at 1099, which seems out of place for the product. 

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/conversion%201.png?raw=true)
![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/conversion%202.png?raw=true)

(insert rupees price)

This is because the dataset was downloaded using rupees as currency and therefore I need to convert it to domestic
currency, GBP, in order for it to make sense. 

# Converting the price columns into GBP 

As of writing this project the exchange rate for rupees to GBP is 1:0.0091, therefore I will use excel formulas
to write the conversion and drag the formula down to apply it for all rows

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/convertingColumn1.png)

![Image Alt](https://github.com/CyrilDoce/Project-Data-analyst/blob/main/Images/convertingColumn2.png)
(insert converting column 1&2)

# Creating pivot tables

By selecting the data and creating pivot tables I will be able to extract meaningful insights into the data that
may be useful for stakeholders .


(check excel data analysis spreadsheet)

FinalProductTable.xlsx -> Data analysis

One important condition that must be taken into account is whether or not total units sold have been affected after the discount. For instance, for some products the discount may be minimal and therefore wont affect sales growth by much, whilst others may have a drastic impact on sales performance . Unfortunately for this data there is no date to indicate whether or not customers have bought the product before or after the discount as there is no date column to record it. Therefore, I will be assuming this data is recorded after the discount and all customers are buying at the discounted price.
