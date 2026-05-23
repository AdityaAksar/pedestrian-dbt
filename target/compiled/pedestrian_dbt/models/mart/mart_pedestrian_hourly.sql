

-- Mart utama: data per jam per sensor, siap untuk Power BI dan forecasting
select
    -- Keys
    pedestrian_id,
    location_id,
    sensor_name,
    sensor_description,

    -- Waktu
    sensing_datetime,
    sensing_date,
    hour_of_day,
    day_of_week,
    month,
    year,
    quarter,
    is_weekend,
    is_public_holiday,
    holiday_name,

    -- Counts
    pedestrian_count,
    direction_1_count,
    direction_2_count,

    -- Lokasi
    latitude,
    longitude,
    direction_1_name,
    direction_2_name,

    -- Cuaca
    temperature_c,
    precipitation_mm,
    windspeed_ms,
    humidity_pct

from `melbourne-pedestrian-pipeline`.`staging`.`int_pedestrian_enriched`