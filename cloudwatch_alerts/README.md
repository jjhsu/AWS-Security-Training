## AWS Cloudwatch Alarms

> Amazon Cloudwatch Alarms allows you to watch CloudWatch metrics and receive notifications when the metrics fall outside of the threshold configured (high or low). You can attach multiple Alarms to each metric that can have multiple actions.


##### Step 1:

* Open Terminal

![](img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/cloudwatch_alarm/lab`

    ```commandline
    cd /home/vagrant/Desktop/Labs/AWS-Security-Training/cloudwatch_alarm/lab
    ```
##### Step 3:

* Run `terraform apply`

**Note:** Once you run the command, it will ask you for permission to perform actions (`Do you want to perform these actions?`). Type `yes` and press `enter`, it will continue with rest of the necessary actions.

```commandline
terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

+ tls_private_key.ucsf_test_key
      id:                                                                  <computed>
      algorithm:                                                           "RSA"
      ecdsa_curve:                                                         "P224"
      private_key_pem:                                                     <computed>
      public_key_fingerprint_md5:                                          <computed>
      public_key_openssh:                                                  <computed>
      public_key_pem:                                                      <computed>
      rsa_bits:                                                            "4096"


Plan: 28 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
  Apply complete! Resources: 23 added, 0 changed, 2 destroyed.
```

##### Step 4 :
 
**cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/cloudwatch_alarm/lab`

* Give necessary permission to `ucsf_cloudwatch.pem` file

```commandline
chmod 400 ucsf_cloudwatch.pem
```

##### Step 5 :

* Open AWS console on the browser and check the created `Cloudwatch Alarms `.

##### Step 6 :

* Open terminal

* **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/cloudwatch_alarm/lab`

* Run `ssh -i ucsf_cloudwatch.pem ec2-user@<yourec2 instance public DNS>`

```commandline
ssh -i ucsf_cloudwatch.pem ec2-user@<yourec2 instance public DNS>
ECDSA key fingerprint is SHA256:RI0dniMEy2SoWdwF2L3dNPBfkI2r85qa9fFZm6xrgo0.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ec2-18-212-10-166.compute-1.amazonaws.com,18.212.10.166' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
[ec2-user@ip-172-24-0-152 ~]$

```

##### Step 7 :
Open AWS console on the browser and check the alarms created on `Cloudwatch Alarms `.


##### Step 8 :
Go to Terminal and type `exit` to exit from the ec2 server.


##### Step 9 :
 
 * Run `terraform destroy` to remove services related to cloudwatch from AWS.
 
* **Note:** It will ask your permission to destroy cloudwatch realated services from AWS (`Do you really want to destroy all resources?`). Type 'yes' then press `enter` to continue the process.
  
 ```commandline 
 
    Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
  aws_flow_log.ucsf_aws_vpc_flow_log: Destroying... (ID: fl-0213b696e3b6c5c4e)
  aws_iam_role_policy.ucsf_vpc_flow_log_iam_policy: Destroying... (ID: ucsf_flowlogsRole:ucsf_flowlogsRolePolicy)
  aws_iam_role_policy.ucsf_vpc_flow_log_iam_policy: Destruction complete after 1s
  aws_flow_log.ucsf_aws_vpc_flow_log: Destruction complete after 4s
  aws_iam_role.vpc_flow_iam_role: Destroying... (ID: ucsf_flowlogsRole)
  aws_cloudwatch_log_group.vpc_flow_cloud_watch_group: Destroying... (ID: ucsf-aws-vpc-flow-log)
  aws_vpc.ucsf-vpc: Destroying... (ID: vpc-0abd67f8f4ffe1199)
  aws_cloudwatch_log_group.vpc_flow_cloud_watch_group: Destruction complete after 2s
  aws_vpc.ucsf-vpc: Destruction complete after 2s
  aws_iam_role.vpc_flow_iam_role: Destruction complete after 2s

  Destroy complete! Resources: 5 destroyed.  
```
