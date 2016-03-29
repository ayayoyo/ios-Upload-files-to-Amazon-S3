Sample Xcode project to show how to upload your files on S3

These are the steps required to upload files to Amazon S3

1.Create S3- Bucket.
    Login to AWS Management Console https://aws.amazon.com/console/
    Under Storage & Content Delivery Chose S3
    Click “Create Bucket” button to create an new bucket: http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html

    Enter the Bucket Name ‘Your_Bucket_name’, the bucket name has to be unique, if you got an error change the bucket name. 
    Select the region of your bucket.

2. Create Amazon Cognito Account
    Amazon Cognito manages identities and access to your bucket
    From AWS Management Console Chose Cognito under Mobile Services
    Click “Create New Identity Pool” button, enter the name, click create
    Check “Enable access to unauthenticated identities”
    Set The IAM Rules: create new rule for authenticated access and unauthenticated access, click allow
    Click on you cognito you just created, at the top right corner click Edit Identity Pool, Copy Identity pool ID, That’s Your_Identity_Pool_Id

3. Changes inside the project
    Download the project.
    At Constant.swift update COGNITO_POOL_ID with  Your_Identity_Pool_Id and S3_BUCKET_NAME with ‘Your_Bucket_name’
    Build and run 


