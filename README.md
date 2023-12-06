# Protein Sequencing Demo for Drug Discovery

1. Create a Snowflake table (TEST_DB.PUBLIC.PROTEIN) with the sample data in /data/testdata.csv
2. Run /src/setup.sql
3. Upload /data/*.pdb files to @llm_workspace stage.
4. Build the Docker image
   cd /src/docker/
   docker build --rm --platform linux/amd64 -t streamlit_test .
5. Tag and push the image to the image repo

   docker tag streamlit_test <acct>.registry.snowflakecomputing.com/test_db/public/images/streamlit_test
   docker push <acct>.registry.snowflakecomputing.com/test_db/public/images/streamlit_test
6. Run /src/create_service.sql

   Get the endpoint URL from DESCRIBE .. output, launch the Streamlit app.


   
