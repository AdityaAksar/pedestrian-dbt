with source as (
    select * from `melbourne-pedestrian-pipeline`.`raw`.`public_holidays`
),

renamed as (
    select
        cast(date as DATE)          as holiday_date,
        cast(name as STRING)        as holiday_name,
        cast(is_national as BOOL)   as is_national,
        cast(year as INT64)         as year,
        cast(ingested_at as TIMESTAMP) as ingested_at
    from source
)

select * from renamed