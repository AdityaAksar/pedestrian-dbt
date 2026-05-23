
    
    

with dbt_test__target as (

  select pedestrian_id as unique_field
  from `melbourne-pedestrian-pipeline`.`staging`.`mart_pedestrian_hourly`
  where pedestrian_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


