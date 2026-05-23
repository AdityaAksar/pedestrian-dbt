

-- Mart agregasi harian per sensor (untuk trend dashboard)
select
    location_id,
    sensor_name,
    sensor_description,
    sensing_date,
    day_of_week,
    month,
    year,
    quarter,
    is_weekend,
    is_public_holiday,
    holiday_name,
    latitude,
    longitude,

    -- Agregasi harian
    sum(pedestrian_count)           as daily_total,
    avg(pedestrian_count)           as hourly_avg,
    max(pedestrian_count)           as peak_hourly_count,
    min(pedestrian_count)           as min_hourly_count,

    -- Peak hour
    max_by(hour_of_day, pedestrian_count) as peak_hour,

    -- Cuaca rata-rata harian
    avg(temperature_c)              as avg_temperature_c,
    sum(precipitation_mm)           as total_precipitation_mm,
    avg(windspeed_ms)               as avg_windspeed_ms,
    avg(humidity_pct)               as avg_humidity_pct

from `melbourne-pedestrian-pipeline`.`staging`.`mart_pedestrian_hourly`
group by
    location_id, sensor_name, sensor_description,
    sensing_date, day_of_week, month, year, quarter,
    is_weekend, is_public_holiday, holiday_name,
    latitude, longitude