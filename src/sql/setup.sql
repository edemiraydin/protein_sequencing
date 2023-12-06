CREATE DATABASE TEST_DB;

USE DATABASE TEST_DB;
USE WAREHOUSE COMPUTE_WH;


CREATE OR REPLACE STAGE YAML_STAGE;
create stage if not exists llm_workspace encryption = (type = 'SNOWFLAKE_SSE');
 

-- create a pool
DROP  COMPUTE POOL streamlit_pool;
CREATE  COMPUTE POOL streamlit_pool
with instance_family=STANDARD_2
min_nodes=1 
max_nodes=1;

create image repository test_db.public.images;

