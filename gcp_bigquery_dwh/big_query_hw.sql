-- Creating external table referring to gcs path 
CREATE OR REPLACE EXTERNAL TABLE `dezoomcamp.external_yellow_tripdata`
OPTIONS (
  format = 'CSV',
  uris = ['gs://dtc_data_lake_dtc-de-375803/hw3/fhv_tripdata_2019-*.csv.gz']
);

CREATE OR REPLACE TABLE `dezoomcamp.yellow_tripdata`
AS SELECT * FROM `dezoomcamp.external_yellow_tripdata`;


CREATE OR REPLACE TABLE `dezoomcamp.yellow_tripdata_partitioned`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY affiliated_base_number AS (
  SELECT * FROM `dezoomcamp.yellow_tripdata`
);


SELECT
  DISTINCT affiliated_base_number
FROM
  dezoomcamp.yellow_tripdata
WHERE
  pickup_datetime BETWEEN '2019-03-01'
  AND '2019-03-31'

SELECT
  DISTINCT affiliated_base_number
FROM
  dezoomcamp.yellow_tripdata_partitioned
WHERE
  pickup_datetime BETWEEN '2019-03-01'
  AND '2019-03-31'