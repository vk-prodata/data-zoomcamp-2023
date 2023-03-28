{{ config(materialized='table') }}

with job_listing as (
    select * from {{ ref('stg_job_listing') }}
),

dim_title as (
    select * from {{ ref('dim_title') }}
),

dim_location as (
    select * from {{ ref('dim_location') }}
),

dim_company as (
    select * from {{ ref('dim_company') }}
)

select 
    dl.loc_id,
    dc.company_id,
    dt.title_id,
    jl.avg_salary

from job_listing jl
inner join dim_title as dt
on jl.title = pickup_zone.title
inner join dim_location as dl
on jl.city = dl.city and jl.state = dk.state
inner join dim_company as dc
on jl.company = dc.company
