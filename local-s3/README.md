# Local S3 Mock Server

Lightweight, Netty-based local Amazon S3 mock storage (`luofuxiang/local-s3`).

## Quick Start
```bash
docker compose up -d
```

To stop:
```bash
docker compose down
```

## Configuration & Credentials
- **Endpoint URL:** `http://localhost:9000`
- **Access Key:** `test` (or any string)
- **Secret Key:** `test` (or any string)
- **Region:** `us-east-1`
- **Addressing Style:** Path-style (`force_path_style: true` / `s3ForcePathStyle: true`) - **REQUIRED**
- **Host Storage:** `/home/eshan/docker-volumes/local-s3/data`

## Environment Variables (.env / bashrc)
```dotenv
AWS_ENDPOINT_URL=http://localhost:9000
AWS_ACCESS_KEY_ID=test
AWS_SECRET_ACCESS_KEY=test
AWS_DEFAULT_REGION=us-east-1
AWS_S3_FORCE_PATH_STYLE=true
```

## Python (Boto3) Example
```python
import boto3
from botocore.client import Config

s3 = boto3.client(
    's3',
    endpoint_url='http://localhost:9000',
    aws_access_key_id='test',
    aws_secret_access_key='test',
    region_name='us-east-1',
    config=Config(s3={'addressing_style': 'path'})
)

s3.create_bucket(Bucket='my-bucket')
```
