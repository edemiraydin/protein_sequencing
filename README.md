# Protein Sequencing Demo for Drug Discovery

This demo shows how we can use OSS Streamlit to deploy data apps in SPCS.

1. Create a Snowflake table (TEST_DB.PUBLIC.PROTEIN) with the sample data in /data/testdata.csv
2. Run /src/setup.sql
3. Upload /data/*.pdb files to @llm_workspace stage.
4. Build the Docker image
   cd /src/docker/
   docker build --rm --platform linux/amd64 -t streamlit_test .
5. Tag and push the image to the image repo

   docker tag streamlit_test <acct>.registry.snowflakecomputing.com/test_db/public/images/streamlit_test
   docker push <acct>.registry.snowflakecomputing.com/test_db/public/images/streamlit_test
6. Push spec.yaml into @yaml_stage using SnowSQL.

   use database TEST_DB;
   put file:///../docker/spec.yaml @yaml_stage overwrite=true auto_compress=false;
8. Run /src/create_service.sql

   Get the endpoint URL from the
   DESCRIBE SERVICE STREAMLIT;
    output, launch the Streamlit app.

   <img width="1344" alt="image" src="https://github.com/edemiraydin/protein_sequencing/assets/10012908/fb46fdbf-499c-4d87-a79a-d3c127ddcb1c">



   
