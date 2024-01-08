USE bike_share;

# How casual riders & annual members use Cylistic bikes differently

-- 1. Total rides made in the First quarter of 2023
SELECT 
	member_casual,
	COUNT(ride_id)
FROM
	bike_q1
GROUP BY
    member_casual; 

-- 2. Distribution of rides by the day in each month
SELECT 
	day_of_week day_of_week_1,
	month,
	COUNT(*) total_rides
FROM 
	bike_q1
GROUP BY 
	month,
	day_of_week
ORDER BY 
	2,1;		     
 
 -- 3. Distribution of rides by the hour
 SELECT 
	LEFT(time,2) start_hour,
    member_casual,
	COUNT(*) total_rides
FROM 
	bike_q1
GROUP BY 
	member_casual,
    start_hour
ORDER BY 
	1,3 DESC;
    
-- 4 Longest and shortest ride duration information
-- 4.1 The longest ride duration 
SELECT
	MAX(ride_duration) logest_ride_duration
FROM 
	bike_q1; -- '39:09:21'

-- 4.2 The shortest ride duration 
SELECT
	MIN(ride_duration) shortest_ride_duration
FROM 
	bike_q1; -- '00:00:01'
  
-- 4.3 The longest ride duration info
SELECT
	MAX(ride_duration) longest_ride_duration,
    member_casual,
    day_of_week,
    month,
    time,
    start_station_name
FROM 
	bike_q1
GROUP BY 
	member_casual,
    day_of_week,
	month,
    time,
    start_station_name
HAVING
	longest_ride_duration >= '00:15:00' AND
    start_station_name <> 'Unknown'
ORDER BY
	1 DESC
LIMIT 50;
  
-- 4.4 The shortest ride duration info
SELECT
	MIN(ride_duration) shortest_ride_duration,
    member_casual,
    day_of_week,
    month,
    time,
    start_station_name
FROM 
	bike_q1
GROUP BY 
	member_casual,
    day_of_week,
	month,
    time,
    start_station_name
HAVING
	shortest_ride_duration > '00:01:00' AND
    start_station_name <> 'Unknown'
ORDER BY
	1, 5
LIMIT 50; 
  
-- 5. Distribution of rides based on start and end stations
SELECT 
	start_station_name,
    end_station_name,
    COUNT(ride_id)
FROM 
	bike_q1
WHERE 
	start_station_name <> 'Unknown' AND
    end_station_name <> 'Unknown'
GROUP BY
	1,2
ORDER BY
	3 DESC;
    
-- 6. Most popular start and end station for riders 
-- 6.1  Most popular start stations
SELECT
	start_station_name,
    COUNT(ride_id) total_ride
FROM
	bike_q1
WHERE 
	start_station_name <> 'Unknown'    
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT
	5;
-- 6.2  Most popular end stations
SELECT
	end_station_name,
    COUNT(ride_id) total_ride
FROM
	bike_q1
WHERE 
	end_station_name <> 'Unknown'    
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT
	5; 

-- 7. Seasonal patterns among cyclists (Valentine's Day 02-14) (Presidents' Day 02-20) (Easter Sunday 04-09) (WINTER Jan-Mar, SPRING Apr)
-- 7.1 Valentine's Day
SELECT
	member_casual,
    LEFT(time,2) start_hour,
    COUNT(*) total_ride
FROM 
	bike_q1
WHERE
	LEFT(started_at, 10) = '2023-02-14'
GROUP BY
	2,1
ORDER BY
	start_hour,
    total_ride DESC;
-- 7.2 (Easter Sunday 09-04) Activites in bike ride
SELECT
	member_casual,
    LEFT(time,2) start_hour,
    COUNT(*) total_ride
FROM 
	bike_q1
WHERE
	LEFT(started_at, 10) = '2023-04-09'
GROUP BY
	2,1
ORDER BY
	start_hour,
    total_ride DESC;  
-- 7.3 (WINTER Jan-Mar) Activites in bike ride
SELECT
	member_casual,
    day_of_week,
    month,
    COUNT(*) total_ride
FROM 
	bike_q1
WHERE
	month = 1 OR
    month = 2 OR
    month = 3
GROUP BY
	2,1,3
ORDER BY
	day_of_week,
    month,
    total_ride DESC; 
-- 7.4 (SPRING Apr) Activites in bike ride
SELECT
	member_casual,
    day_of_week,
    month,
    COUNT(*) total_ride
FROM 
	bike_q1
WHERE
    month = 4
GROUP BY
	2,1,3
ORDER BY
	day_of_week,
    month,
    total_ride DESC;     

-- 8. Distribution of rides by type
SELECT
	month,
	LEFT(time,2) start_hour,
    member_casual,
    rideable_type,
	ride_duration,
    start_station_name,
    end_station_name,
    COUNT(ride_id) total_ride
FROM
	bike_q1
WHERE
    start_station_name <> 'Unknown' AND
    end_station_name <> 'Unknown' AND
    ride_duration >= '00:01:00'
GROUP BY
	1,2,3,4,5,6,7
ORDER BY
	2,
    5 DESC,
    8 DESC;  
  
-- 9. Member and Casual behavior in the weekend VS weekday
SELECT
	CASE 
		WHEN day_of_week = 'Friday' THEN 'Weekend'
        WHEN day_of_week = 'Saturday' THEN 'Weekend'
		ELSE 'Weekday'
	END AS weekend_weekday,
    member_casual,
    rideable_type,
	TIME(ride_duration),
    start_station_name,
    end_station_name,
    COUNT(ride_id)
FROM
	bike_q1
WHERE
    start_station_name <> 'Unknown' AND
    end_station_name <> 'Unknown' AND
    ride_duration >= '00:01:00'
GROUP BY
	1,2,3,4,5,6
ORDER BY
	1,
    4 DESC;    

-- 10. Total ride in weekend VS. weekday
 SELECT
	CASE 
		WHEN day_of_week = 'Friday' THEN 'Weekend'
        WHEN day_of_week = 'Saturday' THEN 'Weekend'
        ELSE 'Weekday'
	END AS weekend_weekday,
    member_casual,
    COUNT(ride_id)
FROM
	bike_q1
GROUP BY
	1,2;      
