import gspread
import pandas as pd
from google.cloud import bigquery
import os

gc = gspread.service_account(filename='service_account/starry-hawk-411609-44a661d6e3f8.json')
sh = gc.open("Training History")
data = sh.sheet1.get_all_values()
df = pd.DataFrame(data[1:], columns=data[0])

os.environ['GOOGLE_APPLICATION_CREDENTIALS']="service_account/starry-hawk-411609-4ce5317f6b2f.json"

# Define target table in BQ
dataset_id = "Test_Akasia"
table_name = "training_history"
project_id = "starry-hawk-411609"

bq_client = bigquery.Client(project=project_id)
table_id = f'{project_id}.{dataset_id}.{table_name}'
job_config = bigquery.LoadJobConfig(
    create_disposition='CREATE_IF_NEEDED',
    write_disposition='WRITE_TRUNCATE'
)
job = bq_client.load_table_from_dataframe(
    df, table_id, job_config=job_config
)
job.result()