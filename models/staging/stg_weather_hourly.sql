with source as (
    select * from `melbourne-pedestrian-pipeline`.`raw`.`weather_hourly`
),

renamed as (
    select
        cast(datetime as TIMESTAMP)             as weather_datetime,
        cast(date as DATE)                      as weather_date,
        cast(hour as INT64)                     as hour_of_day,
        cast(temperature_c as FLOAT64)          as temperature_c,
        cast(precipitation_mm as FLOAT64)       as precipitation_mm,
        cast(windspeed_ms as FLOAT64)           as windspeed_ms,
        cast(humidity_pct as FLOAT64)           as humidity_pct,
        cast(ingested_at as TIMESTAMP)          as ingested_at
    from source
)

select * from renamed
