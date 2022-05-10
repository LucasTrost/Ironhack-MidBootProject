-- SQL questions - regression

use housing;

#1. Create a database called house_price_regression
# (can't alter schema name)

#2. Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns

#3 Import the data from the csv file into the table

#4 Select all the data from table house_price_data 
select * from house_price_data;

#5. Use the alter table command to drop the column date from the database, 
#	as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. 
#	Limit your returned results to 10.
alter table house_price_data drop column date;

select * from house_price_data
limit 10;

#6. Use sql query to find how many rows of data you have.
select count(*)
from house_price_data;

#7. Now we will try to find the unique values in some of the categorical columns:
select count(distinct bedrooms), count(distinct bathrooms), count(distinct floors), count(distinct hpd.condition)
, count(distinct grade) from house_price_data as hpd;

#8. Arrange the data in a decreasing order by the price of the house. 
#	Return only the IDs of the top 10 most expensive houses in your data.
select * from house_price_data
order by price desc
limit 10;

#9. What is the average price of all the properties in your data?
select avg(price) from house_price_data;

#10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
-- What is the average price of the houses grouped by bedrooms?
select bedrooms, avg(price) as average_price from house_price_data
group by bedrooms;

-- What is the average sqft_living of the houses grouped by bedrooms?
select bedrooms, avg(sqft_living) as average_living_space from house_price_data
group by bedrooms;

-- What is the average price of the houses with a waterfront and without a waterfront?
select waterfront, avg(price) as average_price from house_price_data
group by waterfront;

-- Is there any correlation between the columns condition and grade??
select hpd.condition, avg(grade) as average_grade from house_price_data as hpd
group by hpd.condition;

select grade, avg(hpd.condition) as average_condition from house_price_data as hpd
group by grade;

#11. One of the customers is only interested in the following houses:
select * from house_price_data as hpd
where bedrooms = 3 and bedrooms = 4 and floors = 1 and waterfront = 0 
and hpd.condition >= 3 and grade >= 5 and price <= 300000;

#12. Your manager wants to find out the list of properties whose prices are twice more 
#	 than the average of all the properties in the database
select * from house_price_data 
where price >= 2 * (select avg(price) from house_price_data);

#13. Since this is something that the senior management is regularly interested in, create a view of the same query.
create view double_above_avg as
select * from house_price_data 
where price >= 2 * (select avg(price) from house_price_data);

#14. Most customers are interested in properties with three or four bedrooms. 
#	 What is the difference in average prices of the properties with three and four bedrooms?
select avg(price) - (select avg(price) from house_price_data 
where bedrooms = 3) as difference_on_avg from house_price_data 
where bedrooms = 4;

#15. What are the different locations where properties are available in your database? (distinct zip codes)
select distinct zipcode from house_price_data;

#16. Show the list of all the properties that were renovated.

select id from house_price_data
where yr_renovated != 0;

#17. Provide the details of the property that is the 11th most expensive property in your database.
select * from house_price_data
order by price desc
LIMIT 1 OFFSET 11;