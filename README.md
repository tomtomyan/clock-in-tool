# clock-in-tool

Automated tool for clocking in/out from EZLM using AWS Lambda and Cloudwatch and uploads results into S3 bucket. 

Usage:

```
<add login credentials in index.js>
zip lambda.zip index.js
terraform init
terraform plan
terraform apply
```
