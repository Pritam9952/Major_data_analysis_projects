DROP TABLE IF EXISTS road_accidents

CREATE TABLE road_accidents (
    id SERIAL PRIMARY KEY,
    time TIME,
    day_of_week TEXT,
    age_band_of_driver TEXT,
    sex_of_driver TEXT,
    educational_level TEXT,
    vehicle_driver_relation TEXT,
    driving_experience TEXT,
    type_of_vehicle TEXT,
    owner_of_vehicle TEXT,
    service_year_of_vehicle TEXT,
    defect_of_vehicle TEXT,
    area_accident_occured TEXT,
    lanes_or_medians TEXT,
    road_allignment TEXT,
    types_of_junction TEXT,
    road_surface_type TEXT,
    road_surface_conditions TEXT,
    light_conditions TEXT,
    weather_conditions TEXT,
    type_of_collision TEXT,
    number_of_vehicles_involved INT,
    number_of_casualties INT,
    vehicle_movement TEXT,
    casualty_class TEXT,
    sex_of_casualty TEXT,
    age_band_of_casualty TEXT,
    casualty_severity TEXT,
    work_of_casuality TEXT,
    fitness_of_casuality TEXT,
    pedestrian_movement TEXT,  
    cause_of_accident TEXT,
    accident_severity TEXT
);


COPY road_accidents(
time, day_of_week, age_band_of_driver, sex_of_driver,
    educational_level, vehicle_driver_relation, driving_experience,
    type_of_vehicle, owner_of_vehicle, service_year_of_vehicle, defect_of_vehicle,
    area_accident_occured, lanes_or_medians, road_allignment, types_of_junction,
    road_surface_type, road_surface_conditions, light_conditions,
    weather_conditions, type_of_collision, number_of_vehicles_involved,
    number_of_casualties, vehicle_movement, casualty_class, sex_of_casualty,
    age_band_of_casualty, casualty_severity, work_of_casuality,
    fitness_of_casuality, pedestrian_movement, cause_of_accident,
    accident_severity
	)
FROM 'E:\MAJOR_DATA_ANALYSIS_PROJECT\Road Accident India\Road_accident_data.csv'
DELIMITER ','
CSV HEADER;