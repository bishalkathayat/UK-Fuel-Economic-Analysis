USE uk_economy_db;
SELECT 
price_date,
petrol_price,
diesel_price,
round(petrol_price-LAG(Petrol_Price,1) OVER (ORDER BY price_date),2) AS wow_petrol_change,
round(diesel_price - lag(diesel_price,1) over (order by price_date),2) as wow_diesel_change,
round(avg(petrol_price) over (order by price_date rows BETWEEN 3 PRECEDING and CURRENT ROW),2) as petrol_4wk_avg,
round(avg(diesel_price) over (order by price_date rows between 3 PRECEDING and current ROW),2) as diesel_4wk_avg 
FROM fuel_prices;