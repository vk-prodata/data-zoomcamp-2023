{{ config(materialized='table') }}

with stg_fhv_tripdata as (
    select *, 
        'Yellow' as service_type
    from {{ ref('stg_fhv_tripdata') }}
), 

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    sft.dispatching_base_num,
    sft.Affiliated_base_number,
    sft.SR_Flag,
    sft.pickup_locationid,
    sft.dropoff_locationid,
    
    -- timestamps
    sft.pickup_datetime,
    sft.dropoff_datetime,

    sft.tripid,  
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone
from stg_fhv_tripdata sft
inner join dim_zones as pickup_zone
on sft.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on sft.dropoff_locationid = dropoff_zone.locationid
