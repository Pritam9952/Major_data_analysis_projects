SELECT * FROM road_accidents

-- PART 1 >> Basic Dataset Overview
-- 1 Total Records, Vehicles & Casualties

SELECT 
	 COUNT(*) AS total_accidents,
	 SUM(number_of_vehicles_involved) AS total_vehicles,
	 SUM(number_of_casualties) AS total_casualties
FROM road_accidents;

-- 2 Unique Categories Check

SELECT
	COUNT(DISTINCT cause_of_accident) AS unique_causes,
	COUNT(DISTINCT type_of_vehicle) AS unique_vehicle_types,
	COUNT(DISTINCT weather_conditions) AS unique_weather_conditions
FROM road_accidents;

-- PART 2 >> Accident Trends
-- 1 Accidents by Day of the Week

SELECT
	day_of_week,
	COUNT(*) AS total_accidents
	FROM road_accidents
GROUP BY day_of_week
ORDER BY total_accidents DESC;

-- 2 Accidents by Time of Day
SELECT
	CASE
		WHEN EXTRACT (HOUR FROM time) BETWEEN 5 AND 11 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM time) BETWEEN 12 AND 16 THEN 'Afternonn'
		WHEN EXTRACT (HOUR FROM time) BETWEEN 17 AND 20 THEN 'Evening'
		ELSE 'Night'
	END AS time_of_day,
	COUNT (*) AS total_accidents
FROM road_accidents
GROUP BY time_of_day
ORDER BY total_accidents DESC;


-- PART 3 >> Driver & Vehicle Analysis

-- 1 Accidents by Driver Age Group

SELECT
	age_band_of_driver,
	COUNT(*) AS total_accidents
FROM road_accidents
GROUP BY age_band_of_driver
ORDER BY total_accidents DESC;

-- 2 Accidents by Type of Vehicle

SELECT
	type_of_vehicle,
	COUNT(*) AS total_accidents
FROM road_accidents
GROUP BY type_of_vehicle
ORDER BY total_accidents DESC
LIMIT 10;


-- PART 4 >> Weather & Road Impact

-- 1 Accidents by Weather Conditions

SELECT 
	 weather_conditions,
	 COUNT(*) AS total_accidents
FROM road_accidents
GROUP BY weather_conditions
ORDER BY total_accidents DESC;


-- 2 Accidents by Road Surface Type

SELECT 
	road_surface_type,
	COUNT(*) AS total_accidents
FROM road_accidents
GROUP BY road_surface_type
ORDER BY total_accidents DESC;


-- PART 5 >> Accident Severity

-- 1 Count Accidents by Severity

SELECT 
	accident_severity,
	COUNT(*) AS total_accidents
FROM road_accidents
GROUP BY accident_severity
ORDER BY total_accidents DESC;

-- 2 Average Casualities by Severity

SELECT
	accident_severity,
	ROUND(AVG(number_of_casualties),2) AS avg_casualties
FROM road_accidents
GROUP BY accident_severity
ORDER BY avg_casualties DESC;



-- PART 6 >> Top Causes of Accidents

SELECT 
	cause_of_accident,
	COUNT(*) AS total_accidents
FROM road_accidents
GROUP BY cause_of_accident
ORDER BY total_accidents DESC
LIMIT 10;


-- PART 7 >> Casualty Analysis

-- 1 Accidents by Casualty Severity

SELECT 
	casualty_severity,
	COUNT(*) AS total_casualties
FROM road_accidents
WHERE casualty_severity IS NOT NULL
GROUP BY casualty_severity
ORDER BY total_casualties DESC;


-- 2 Gender-wise Casualties

SELECT 
	sex_of_casualty,
	COUNT(*) AS total_casualties
FROM road_accidents
GROUP BY sex_of_casualty
ORDER BY total_casualties DESC;



-- FINAL SUMMARY :

CREATE VIEW accident_summary AS
SELECT
	day_of_week,
	weather_conditions,
	road_surface_type,
	accident_severity,
	COUNT(*) AS total_accidents,
	SUM(number_of_casualties) AS total_casualties
FROM road_accidents
GROUP BY day_of_week, weather_conditions, road_surface_type, accident_severity;

SELECT * FROM accident_summary