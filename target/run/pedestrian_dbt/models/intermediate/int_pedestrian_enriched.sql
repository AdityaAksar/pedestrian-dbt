

  create or replace view `melbourne-pedestrian-pipeline`.`staging`.`int_pedestrian_enriched`
  OPTIONS()
  as with pedestrian as (
    select * from `melbourne-pedestrian-pipeline`.`staging`.`stg_pedestrian_counts`
),
 
weather as (
    select * from `melbourne-pedestrian-pipeline`.`staging`.`stg_weather_hourly`
),
 
holidays as (
    select * from `melbourne-pedestrian-pipeline`.`staging`.`stg_public_holidays`
),
 
sensors as (
    select * from `melbourne-pedestrian-pipeline`.`staging`.`stg_sensor_locations`
),
 
-- Join pedestrian dengan weather berdasarkan tanggal dan jam
joined as (
    select
        -- Identifiers
        p.pedestrian_id,
        p.location_id,
        p.sensor_name,
 
        -- Waktu
        p.sensing_datetime,
        p.sensing_date,
        p.hour_of_day,
 
        -- Dimensi waktu (feature engineering)
        extract(dayofweek from p.sensing_date)  as day_of_week,   -- 1=Sunday, 7=Saturday
        extract(month from p.sensing_date)      as month,
        extract(year from p.sensing_date)       as year,
        extract(quarter from p.sensing_date)    as quarter,
        case
            when extract(dayofweek from p.sensing_date) in (1, 7) then true
            else false
        end                                     as is_weekend,
 
        -- Target variable
        p.pedestrian_count,
        p.direction_1_count,
        p.direction_2_count,
 
        -- Lokasi sensor
        p.latitude,
        p.longitude,
        s.sensor_description,
        s.direction_1_name,
        s.direction_2_name,
 
        -- Cuaca (left join karena ada lag)
        w.temperature_c,
        w.precipitation_mm,
        w.windspeed_ms,
        w.humidity_pct,
 
        -- Holiday flag
        case
            when h.holiday_date is not null then true
            else false
        end                                     as is_public_holiday,
        h.holiday_name
 
    from pedestrian p
    left join weather w
        on p.sensing_date = w.weather_date
        and p.hour_of_day = w.hour_of_day
    left join holidays h
        on p.sensing_date = h.holiday_date
    left join sensors s
        on p.location_id = s.location_id
)
 
select * from joined;

