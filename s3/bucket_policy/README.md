## Amazon S3

>


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/s3/bucket_policy`

    ```commandline
    cd  /home/vagrant/Desktop/Labs/AWS-Security-Training/s3/bucket_policy
    ```

##### Step 3:

* Run `terraform init`

```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/bucket_policy# terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.50.0)...
- Downloading plugin for provider "random" (2.0.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.50"
* provider.random: version = "~> 2.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

##### Step 4:

* Get your public IP Address by running: `dig +short myip.opendns.com @resolver1.opendns.com`

* Copy the value generated

* Run `terraform apply`
    1. It will as you to enter a `public_host`, where you can enter the public IP address you identified
    2. It will ask you to enter **Region**
    3. It will ask a permission to do the actions type `yes` and press enter to continue
    
```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/bucket_policy# terraform apply
var.public_host
  Enter a value: <host>

provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_s3_bucket.policy_bucket
      id:                          <computed>
      acceleration_status:         <computed>
      acl:                         "private"
      arn:                         <computed>
      bucket:                      "${random_string.bucket_name.result}-policy-bucket"
      bucket_domain_name:          <computed>
      bucket_regional_domain_name: <computed>
 number:                      "true"
      result:                      <computed>
      special:                     "false"
      upper:                       "false"


Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.bucket_name: Creating...
  length:      "" => "10"
  lower:       "" => "true"
  min_lower:   "" => "0"
  min_numeric: "" => "0"
  min_special: "" => "0"
  min_upper:   "" => "0"
  number:      "" => "true"
  result:      "" => "<computed>"
  special:     "" => "false"
  upper:       "" => "false"
aws_s3_bucket.policy_bucket: Still creating... (10s elapsed)
aws_s3_bucket.policy_bucket: Creation complete after 12s (ID: puprti4347-policy-bucket)
aws_s3_bucket_policy.policy: Creating...
  bucket: "" => "puprti4347-policy-bucket"
  policy: "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Id\": \"BUCKETIPPOLICY\",\n  \"Statement\": [\n      {\n        \"Sid\": \"IPAllow\",\n        \"Effect\": \"Allow\",\n        \"Principal\": {\"AWS\": \"*\"},\n        \"Action\": \"s3:*\",\n        \"Resource\": [\n          \"arn:aws:s3:::puprti4347-policy-bucket\",\n          \"arn:aws:s3:::puprti4347-policy-bucket/*\"\n        ],\n        \"Condition\": {\n           \"IpAddress\": {\"aws:SourceIp\": \"192.168.1.1/32\"}\n        }\n      }\n  ]\n}\n"
aws_s3_bucket_policy.policy: Creation complete after 1s (ID: puprti4347-policy-bucket)

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

```

##### Step 5:

* Run `terraform destroy`

    1. It will as you to enter a `public_host`
    2. It will ask you to enter **Region**
    3. It will ask a permission to do the actions type `yes` and press enter to continue
   
```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/s3/bucket_policy# terraform destroy
var.public_host
  Enter a value: <host>

provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

random_string.bucket_name: Refreshing state... (ID: none)
aws_s3_bucket.policy_bucket: Refreshing state... (ID: puprti4347-policy-bucket)
aws_s3_bucket_policy.policy: Refreshing state... (ID: puprti4347-policy-bucket)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_s3_bucket.policy_bucket

  - aws_s3_bucket_policy.policy

  - random_string.bucket_name


Plan: 0 to add, 0 to change, 3 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_s3_bucket_policy.policy: Destroying... (ID: puprti4347-policy-bucket)
aws_s3_bucket_policy.policy: Destruction complete after 1s
aws_s3_bucket.policy_bucket: Destroying... (ID: puprti4347-policy-bucket)
aws_s3_bucket.policy_bucket: Destruction complete after 1s
random_string.bucket_name: Destroying... (ID: none)
random_string.bucket_name: Destruction complete after 0s

Destroy complete! Resources: 3 destroyed.


```
