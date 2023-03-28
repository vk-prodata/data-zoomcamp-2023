{{ config(materialized='view') }}

with stg_job_listing as 
(
  select *
  from {{ source('staging','stg_job_listing') }}
)

select
    title,
    company
    avg_salary,
    city,
    state
from stg_job_listing

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}