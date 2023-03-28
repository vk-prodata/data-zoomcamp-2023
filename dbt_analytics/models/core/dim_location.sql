{{ config(materialized='table') }}

with job_listing as (
    select * from {{ ref('stg_job_listing') }}
)
select distinct
    {{ dbt_utils.generate_surrogate_key(['city', 'state']) }},
    city,
    state
from job_listing