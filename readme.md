Let's create an Investment portfolio website by creating a s3 bucket using Terraform as follow:

1. Installing Terraform on VM.
2. Define a AWS provider in provider.tf and run terraform init.
3. Creare an AWS S3 bucket in main.tf and define variables in varible.tf and run terraform plan and then terraform apply -auto-approve to execute the changes.
4. Now take the ownership of bucket by adding "aws_s3_bucket_ownership_controls" resource block and make the bucket public by adding "aws_s3_bucket_public_access_block" block and run terraform apply -auto-approve.
5. Add index.html, error.html and styles.css(if required) and define them as the objects in s3 bucket by adding "aws_s3_object" block and hit terraform apply and you see objects for those files will be created.
6. Now, enable the site hosting by adding "aws_s3_bucket_website_configuration" block to make the web page accessible.
7. You can provide the specific domain for the website.
