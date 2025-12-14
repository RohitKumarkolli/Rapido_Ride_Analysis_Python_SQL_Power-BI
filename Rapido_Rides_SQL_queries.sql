SELECT
	*
FROM
	RAPIDO;

--1.What is the total revenue (total_fare) and the total number of rides for each month?
SELECT
	MONTH,
	ROUND(SUM(TOTAL_FARE::NUMERIC), 2),
	COUNT(RIDE_ID)
FROM
	RAPIDO
GROUP BY
	MONTH;

--2.Calculate the average total fare (total_fare) and average base ride charge (ride_charge) for each services type.
SELECT
	SERVICES,
	ROUND(AVG(TOTAL_FARE::NUMERIC), 3) AS AVG_FARECHARGE,
	ROUND(AVG(RIDE_CHARGE::NUMERIC), 3) AS AVG_RIDECHARGE
FROM
	RAPIDO
GROUP BY
	SERVICES;

--3.What are the total rides and total revenue for each payment_method, ordered by descending revenue?
SELECT
	PAYMENT_METHOD,
	COUNT(RIDE_ID) AS TOTAL_RIDES,
	ROUND(SUM(TOTAL_FARE::NUMERIC), 2) AS TOTAL_REVENUE
FROM
	RAPIDO
GROUP BY
	PAYMENT_METHOD
ORDER BY
	TOTAL_REVENUE DESC;

--4.Identify the top 3 time_segments and the top 5 hours with the highest number of rides.

(
	SELECT
		TIME_SEGMENT,
		COUNT(RIDE_ID) AS RIDES
	FROM
		RAPIDO
	GROUP BY
		TIME_SEGMENT
	ORDER BY
		RIDES DESC
	LIMIT
		3
)
UNION ALL
(
	SELECT
		CAST(HOUR AS TEXT),
		COUNT(RIDE_ID) AS RIDES
	FROM
		RAPIDO
	GROUP BY
		HOUR
	ORDER BY
		RIDES DESC
	LIMIT
		5
);

--5.Calculate the average number of rides per day for each day of the week (Monday, Tuesday, etc.).
WITH
	DAILYCOUNT AS (
		SELECT
			DATE,
			DAY,
			COUNT(RIDE_ID) AS TOTAL_RIDES
		FROM
			RAPIDO
		GROUP BY
			DATE,
			DAY
	)
SELECT
	DAY,
	ROUND(AVG(TOTAL_RIDES), 2) AS AVG_RIDES
FROM
	DAILYCOUNT
GROUP BY
	DAY
ORDER BY
	CASE DAY
		WHEN 'Monday' THEN 1
		WHEN 'Tuesday' THEN 2
		WHEN 'Wednesday' THEN 3
		WHEN 'Thursday' THEN 4
		WHEN 'Friday' THEN 5
		WHEN 'Saturday' THEN 6
		WHEN 'Sunday' THEN 7
	END;

--6.Calculate the average fare per kilometer (total_fare / distance) and the average fare per minute (total_fare / duration), grouped by services type.
SELECT
	SERVICES,
	ROUND(
		SUM(TOTAL_FARE::NUMERIC) / SUM(DISTANCE::NUMERIC),
		2
	) AS AVG_FARE
FROM
	RAPIDO
GROUP BY
	SERVICES
ORDER BY
	AVG_FARE DESC;

--7.Find the top 10 longest rides by duration and list their ride_id, services, distance, and total_fare.
SELECT
	RIDE_ID,
	SERVICES,
	DISTANCE,
	TOTAL_FARE
FROM
	RAPIDO
ORDER BY
	DISTANCE DESC
LIMIT
	10;

--8.Calculate the total collected miscellaneous charge (misc_charge) and the percentage it represents of the overall total revenue.
SELECT
	ROUND(SUM(MISC_CHARGE::NUMERIC), 2) AS MISC,
	ROUND(
		SUM(MISC_CHARGE::NUMERIC) / SUM(TOTAL_FARE::NUMERIC),
		3
	) AS PRESENT
FROM
	RAPIDO;

--9.Calculate the percentage increase or decrease in total revenue from the previous 
--month to the current month. (This will require using window functions like LAG()).
WITH
	MONTHLYREVENUE AS (
		-- Step 1: Calculate the total revenue for each month (one row per month)
		SELECT
			MONTH,
			SUM(TOTAL_FARE) AS CURRENT_MONTH_REVENUE,
			-- Select the earliest date in the month to ensure correct chronological sorting
			MIN(DATE) AS MIN_DATE_OF_MONTH
		FROM
			RAPIDO
		GROUP BY
			MONTH
	),
	REVENUEWITHPREVIOUS AS (
		-- Step 2: Use the LAG() window function to pull the previous month's revenue
		SELECT
			MONTH,
			CURRENT_MONTH_REVENUE,
			MIN_DATE_OF_MONTH,
			-- LAG looks back 1 row, ordered by the min_date_of_month, default to 0 if no previous row exists
			LAG(CURRENT_MONTH_REVENUE, 1, 0) OVER (
				ORDER BY
					MIN_DATE_OF_MONTH
			) AS PREVIOUS_MONTH_REVENUE
		FROM
			MONTHLYREVENUE
	)
	-- Step 3: Calculate the percentage increase/decrease
SELECT
	MONTH,
	CURRENT_MONTH_REVENUE,
	PREVIOUS_MONTH_REVENUE,
	-- Formula: ((Current - Previous) / Previous) * 100
	CASE
	-- Avoid division by zero
		WHEN PREVIOUS_MONTH_REVENUE = 0 THEN NULL
		ELSE ROUND(
			-- FIX: Cast the entire calculation to NUMERIC before rounding
			(
				(
					(CURRENT_MONTH_REVENUE - PREVIOUS_MONTH_REVENUE) / PREVIOUS_MONTH_REVENUE
				) * 100
			)::NUMERIC,
			2 -- Round to two decimal places
		)
	END AS REVENUE_CHANGE_PERCENTAGE
FROM
	REVENUEWITHPREVIOUS
ORDER BY
	MIN_DATE_OF_MONTH;

--10.For each month, count the number of rides for each distinct services type.

SELECT
	SERVICES,
	MONTH,
	COUNT(RIDE_ID) AS RIDES
FROM
	RAPIDO
GROUP BY
	MONTH,
	SERVICES
ORDER BY
	MIN(DATE),
	SERVICES;