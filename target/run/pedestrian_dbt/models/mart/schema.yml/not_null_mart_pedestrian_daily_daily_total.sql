
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select daily_total
from `melbourne-pedestrian-pipeline`.`staging`.`mart_pedestrian_daily`
where daily_total is null



  
  
      
    ) dbt_internal_test