import json

def add(x, y):
    return x + y

def main(event, context):
    print("1 + 2 is=>", add(1, 2))
    print("Context:::=>", context)
    print("S3 Event Received:", json.dumps(event, indent=4))
    return {
        "statusCode": 200,
        "body": json.dumps("Lambda executed successfully!")
    }
