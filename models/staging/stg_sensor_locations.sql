with source as (
    select * from `melbourne-pedestrian-pipeline`.`raw`.`sensor_locations`
),
 
renamed as (
    select
        cast(location_id as INT64)          as location_id,
        cast(sensor_description as STRING)  as sensor_description,
        cast(sensor_name as STRING)         as sensor_name,
        cast(installation_date as DATE)     as installation_date,
        cast(note as STRING)                as note,
        cast(location_type as STRING)       as location_type,
        cast(status as STRING)              as status,
        cast(direction_1 as STRING)         as direction_1_name,
        cast(direction_2 as STRING)         as direction_2_name,
        cast(latitude as FLOAT64)           as latitude,
        cast(longitude as FLOAT64)          as longitude,
        cast(ingested_at as TIMESTAMP)      as ingested_at
    from source
)
 
select * from renamed
