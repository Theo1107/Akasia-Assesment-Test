import pyodbc
import pandas as pd
from google.cloud import bigquery
import os
import credentials

conn = pyodbc.connect('DRIVER={ODBC Driver 18 for SQL Server};SERVER=' + credentials.server + ';DATABASE=' + credentials.database + ';UID=' + credentials.username + ';PWD=' + credentials.password)

sql_statement = '''
    SELECT * FROM [TestAkasia].[dbo].[Employee];
'''
cursor = conn.cursor()
cursor.execute(sql_statement)
columns = [col[0] for col in cursor.description]
result = cursor.fetchall()

data = []
for val in result:
    dict_data = {}
    dict_data['Id'] = val[0]
    dict_data['EmployeeId'] = val[1]
    dict_data['FullName'] = val[2]
    dict_data['BirthDate'] = val[3]
    dict_data['Address'] = val[4]
    data.append(dict_data)
df = pd.DataFrame(data, columns=columns)

os.environ['GOOGLE_APPLICATION_CREDENTIALS']="service_account/starry-hawk-411609-4ce5317f6b2f.json"

bq_client = bigquery.Client(project=credentials.project_id)
table_id = f'{credentials.project_id}.{credentials.dataset_id}.{credentials.table_name}'
job_config = bigquery.LoadJobConfig(
    create_disposition='CREATE_IF_NEEDED',
    write_disposition='WRITE_TRUNCATE'
)
job = bq_client.load_table_from_dataframe(
    df, table_id, job_config=job_config
)
job.result()
