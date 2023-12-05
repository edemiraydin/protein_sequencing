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

DROP SERVICE streamlit;
CREATE SERVICE streamlit
  MIN_INSTANCES = 1
  MAX_INSTANCES = 1
  COMPUTE_POOL = streamlit_pool
  SPEC = '@yaml_stage/spec.yaml';

ls @test_db.public.llm_workspace;

CALL SYSTEM$GET_SERVICE_STATUS('TEST_DB.PUBLIC.STREAMLIT', 100); 
DESCRIBE SERVICE STREAMLIT; -- get the endpoint URL for the streamlit app
CALL SYSTEM$GET_SERVICE_LOGS('TEST_DB.PUBLIC.STREAMLIT', '0', 'streamlit');
