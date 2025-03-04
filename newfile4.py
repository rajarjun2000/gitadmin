import boto3
import time
from datetime import datetime, timedelta, timezone


# Initialize the S3 client
s3 = boto3.client('s3')

# Define the bucket name and subfolder (prefix)
bucket_name = 'myrajkumarbucket'
prefix = 'raju'  # Update with your subfolder path, leave empty for the entire bucket

# Calculate the time 10 minutes ago
time_limit = datetime.now(timezone.utc) - timedelta(minutes=10)
time_limit_timestamp = time_limit.timestamp()

# List objects in the S3 bucket (with the given prefix)
response = s3.list_objects_v2(Bucket=bucket_name, Prefix=prefix)

# Check and filter files older than 10 minutes
if 'Contents' in response:
    for obj in response['Contents']:
        last_modified = obj['LastModified']
        last_modified_timestamp = last_modified.timestamp()

        # If the file is older than 10 minutes, print its name
        if last_modified_timestamp < time_limit_timestamp:
            print(f"File: {obj['Key']} is older than 10 minutes. Last modified: {last_modified}")
else:
    print("No files found in the specified S3 bucket and subfolder.")
