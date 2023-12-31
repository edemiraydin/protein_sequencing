
USE DATABASE TEST_DB;
USE WAREHOUSE COMPUTE_WH;

-- make sure images are pushed into the image repo
call system$registry_list_images('/test_db/public/images');

--DROP SERVICE streamlit;
CREATE SERVICE streamlit
  MIN_INSTANCES = 1
  MAX_INSTANCES = 1
  COMPUTE_POOL = streamlit_pool
  SPEC = '@yaml_stage/spec.yaml';

ls @test_db.public.llm_workspace;

CALL SYSTEM$GET_SERVICE_STATUS('TEST_DB.PUBLIC.STREAMLIT', 100); 
DESCRIBE SERVICE STREAMLIT; -- get the endpoint URL for the streamlit app
CALL SYSTEM$GET_SERVICE_LOGS('TEST_DB.PUBLIC.STREAMLIT', '0', 'streamlit');

