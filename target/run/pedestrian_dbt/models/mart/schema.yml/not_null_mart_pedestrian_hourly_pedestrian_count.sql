
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pedestrian_count
from `melbourne-pedestrian-pipeline`.`staging`.`mart_pedestrian_hourly`
where pedestrian_count is null



  
  
      
    ) dbt_internal_test