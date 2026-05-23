

  create or replace view `melbourne-pedestrian-pipeline`.`staging`.`stg_pedestrian_counts`
  OPTIONS()
  as with source as (
    select * from `melbourne-pedestrian-pipeline`.`raw`.`pedestrian_counts`
),

renamed as (
    select
        cast(id as INT64)                           as pedestrian_id,
        cast(location_id as INT64)                  as location_id,
        cast(sensor_name as STRING)                 as sensor_name,
        cast(sensing_date as DATE)                  as sensing_date,
        cast(hourday as INT64)                      as hour_of_day,
        cast(sensing_datetime as TIMESTAMP)         as sensing_datetime,
        cast(direction_1 as INT64)                  as direction_1_count,
        cast(direction_2 as INT64)                  as direction_2_count,
        cast(pedestriancount as INT64)              as pedestrian_count,
        cast(lon as FLOAT64)                        as longitude,
        cast(lat as FLOAT64)                        as latitude,
        cast(ingested_at as TIMESTAMP)              as ingested_at
    from source
)

select * from renamed;

