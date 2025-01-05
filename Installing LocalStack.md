# LocalStack

- Open source tool

- Mimics behaviour of AWS cloud services.

- Provides an interface for local environment testing and development on application in AWS.

## Installation:

- Requires **docker** and **python, pip** to be installed locally.

- Install with pip: ``pip install localstack`` => [Docs](https://pypi.org/project/localstack/)

- Install localstack aws cli: ``pip install awscli-local`` => [Docs](https://pypi.org/project/awscli-local/)


## Localstack Handy Commands:

- **Start localstack Server:** ``localstack start``

- **Check Running Services::** ``localstack status services``

- **View Logs:** ``localstack logs``

- **Stop Localstack:** ``localstack stop``

- **Test Service Health**: `` curl -X GET http://localhost:4566/health``



## AWS Local / AWS Commands:

Note that `awslocal` and `aws` have similar usage syntatic sugar.

> **Help:** ``aws <service> help``

**S3 Buckets:**

- **List Buckets:** ``awslocal s3 ls``

- **Create A Bucket:** ``awslocal ``

- **Upload a File to a Bucket** ``awslocal s3 cp file.txt s3://my-bucket/``

- **List Buckets Content:** ``awslocal s3 ls s3://my-bucket``

- **List Buckets:** ``awslocal s3 ls``
