
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select sensing_date
from `melbourne-pedestrian-pipeline`.`staging`.`mart_pedestrian_daily`
where sensing_date is null



  
  
      
    ) dbt_internal_test