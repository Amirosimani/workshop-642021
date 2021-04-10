# Replace with your AWS account ID and your Region, e.g. us-east-1, us-west-2
ACCOUNT_ID = 367158743199
REGION = us-east-1

# create a repository in ECR, and then login to ECR repository
aws --region ${REGION} ecr create-repository --repository-name smstudio-custom
aws ecr --region ${REGION} get-login-password | docker login --username AWS \
    --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/smstudio-custom

# Build the docker image and push to Amazon ECR (modify image tags and name as required)
$(aws ecr get-login --region ${REGION} --no-include-email)
docker build . -t smstudio-r -t ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/smstudio-custom:r
docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/smstudio-custom:r

# Using with SageMaker Studio
## Create SageMaker Image with the image in ECR (modify image name as required)
ROLE_ARN = "<YOUR EXECUTION ROLE ARN>"

aws sagemaker create-image \
    --region ${REGION} \
    --image-name custom-r \
    --role-arn ${ROLE_ARN}

aws sagemaker create-image-version \
    --region ${REGION} \
    --image-name custom-r \
    --base-image ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/smstudio-custom:r

## Create AppImageConfig for this image (modify AppImageConfigName and 
## KernelSpecs in app-image-config-input.json as needed)
## note that 'file://' is required in the file path
aws sagemaker create-app-image-config \
    --region ${REGION} \
    --cli-input-json file://app-image-config-input.json