CREATE DATABASE Economics_impacts;

USE Economics_impacts;

CREATE TABLE countries (
Country_id INT PRIMARY KEY,
Name varchar(55)
);

CREATE TABLE industries(
IND_id INT PRIMARY KEY,
Name varchar(55)
);

CREATE TABLE economic_data(
EC_id INT primary key,
Country_id INT,
IND_id INT,
quarterly_revenue_2019 DECIMAL(10,2),
quarterly_revenue_2020 DECIMAL(10,2),
percentage_change DECIMAL(5,2),
constraint C_country_id FOREIGN KEY(Country_id) REFERENCES countries(Country_id),
constraint C_IND_id FOREIGN KEY(IND_id) REFERENCES industries(IND_id)
);

CREATE TABLE economic_indicators(
EI_ID int primary key,
Country_id int,
indicator_name varchar(255),
value DECIMAL(10,2),
year int,
quarter int,
constraint E_country FOREIGN KEY(Country_id) REFERENCES countries(Country_id)
);

insert into countries values
(1,'Australia'),
(2,'Canada'),
(3,'India'),
(4,'France'),
(5,'united kingdom'),
(6,'Switzerland'),
(7,'Spain'),
(8,'Swden'),
(9,'China'),
(10,'Italy');

insert into industries values
(1,'Renewable Energy'),
(2,'E-commerce'),
(3,'Cybersecurity'),
(4,'Artificial Intelligence'),
(5,'Healthcare Technology'),
(6,'Financial Services'),
(7,'Tourism'),
(8,'Agriculture'),
(9,'Logistics'),
(10,'Manufacturing');

insert into economic_data values
(1,1,1,50000000,40000000,25.00),
(2,2,2,80000000,60000000,33.33),
(3,3,3,30000000,20000000,50.00),
(4,4,4,4000000,30000000,33.33),
(5,5,5,2000000,15000000,33.33),
(6,6,6,10000000,80000000,25.00),
(7,7,7,5000000,40000000,25.00),
(8,8,8,80000000,60000000,33.33),
(9,9,9,30000000,20000000,50.00),
(10,10,10,40000000,30000000,33.33),
(11,1,2,20000000,15000000,33.33),
(12,2,3,10000000,80000000,25.00),
(13,3,4,50000000,40000000,25.00),
(14,4,5,30000000,20000000,50.00),
(15,5,6,80000000,60000000,33.33);

insert into economic_indicators values
(1,1,'GDP',10000.00,2022,1),
(2,1,'Inflation Rate',2.50,2022,1),
(3,1,'Unemployment Rate',4.00,2022,1),
(4,2,'GDP',5000.00,2022,1),
(5,2,'Inflation Rate',3.00,2022,1),
(6,3,'GDP',8000.00,2022,1),
(7,3,'Unemployment Rate',3.50,2022,1),
(8,1,'GDP',11000.00,2022,2),
(9,1,'Inflation Rate',2.80,2022,2),
(10,2,'GDP',5500.00,2022,2);

CREATE TABLE company_performance(
id int primary key,
IND_id int,
revenue DECIMAL(10,2),
profit DECIMAL(10,2),
year INT,
quarter INT,
constraint C_Cid FOREIGN KEY(IND_id) REFERENCES industries(IND_id)
);

insert into company_performance values
(1,1,100000.00,200000.00,2022,1),
(2,1,120000.00,25000.00,2022,2),
(3,2,80000.00,15000.00,2022,1),
(4,2,90000.00,18000.00,2022,2),
(5,3,70000.00,12000.00,2022,1),
(6,3,85000.00,15000.00,2022,3),
(7,1,13000.00,28000.00,2022,3),
(8,2,100000.00,20000.00,2022,3),
(9,3,90000.00,18000.00,2022,3),
(10,1,140000.00,30000.00,2022,4);

select sum(value) As total_gdp
FROM economic_indicators
where indicator_name='GDP' AND year=2022;

select IND_id,max(revenue) AS highest_revenue
FROM company_performance
where year=2022
group by IND_id;

select AVG(value) AS average_inflation_rate
FROM economic_indicators
where indicator_name='Inflation Rate' AND year=2022;

select Country_id,min(value) AS lowest_unemployment_rate
FROM economic_indicators
where indicator_name='Unemployment Rate' AND year=2022
group by Country_id;

select sum(profit) AS total_profit
FROM company_performance
where year=2022;

select quarter,max(value) as highest_gdp
from economic_indicators
where country_id=1 and indicator_name='GDP' AND year=2022
group by quarter;

select IND_id,max(profit/revenue) as highest_profit_margin
from company_performance
where year=2022
group by IND_id;

select profit,AVG(revenue) AS highest_average_revenue1
from company_performance
left join industries on company_performance.IND_id=industries.IND_id
where year=2022
group by profit
order by highest_average_revenue1 desc
limit 1;
