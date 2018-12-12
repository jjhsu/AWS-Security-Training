## AWS Elastic Compute Cloud (EC2)

>Using Amazon EC2 eliminates your need to invest in hardware up
 front, so you can develop and deploy applications faster.
  You can use Amazon EC2 to launch as many or as few virtual servers as you need, configure security and networking, and manage storage. Amazon EC2 enables you to scale up or down to handle changes in requirements or spikes in popularity,
 reducing your need to forecast traffic.


In this exercise, our target is to create an environment that looks like this:

![](../../img/VPC_Subnet.png)


##### Step 1:

* Open Terminal

![](../../img/terminal.png)

##### Step 2:

*  **cd** into  `/home/vagrant/Desktop/Labs/AWS-Security-Training/ec2/lab/without_vpc`

    ```commandline
    cd /home/vagrant/Desktop/Labs/AWS-Security-Training/ec2/lab/without_vpc
    ```
##### Step 3:

* Run `terraform init`

    ```commandline
    root@ubuntu:~/Desktop/Labs/AWS-Security-Training/ec2/lab/without_vpc# terraform init
    
    Initializing provider plugins...
    - Checking for available provider plugins on https://releases.hashicorp.com...
    - Downloading plugin for provider "random" (2.0.0)...
    
    The following providers do not have any version constraints in configuration,
    so the latest version was installed.
    
    To prevent automatic upgrades to new major versions that may contain breaking
    changes, it is recommended to add version = "..." constraints to the
    corresponding provider blocks in configuration, with the constraint strings
    suggested below.
    
    * provider.aws: version = "~> 1.49"
    * provider.local: version = "~> 1.1"
    * provider.random: version = "~> 2.0"
    * provider.tls: version = "~> 1.2"
    
    Terraform has been successfully initialized!
    
    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.
    
    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
    
    ```


##### Step 4:

* Run `terraform apply`

    1. It will ask you to enter **Region**
    2. It will ask a permission to do the actions type `yes` and press enter to continue
    
```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/ec2/lab/without_vpc# terraform apply
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value:
  
  data.aws_ami.amz_linux: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_eip.nat
      id:                                          <computed>
      allocation_id:                               <computed>
      association_id:                              <computed>
      domain:                                      <computed>
      instance:                                    <computed>
      

Plan: 21 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.wb: Still creating... (2m10s elapsed)
aws_instance.wb (remote-exec): Python Service is running now
aws_instance.wb (remote-exec): nohup: appending output to ânohup.outâ
aws_instance.wb (remote-exec):  2331 pts/0    S+     0:00 sudo nohup python /app/helloworld/app.py
aws_instance.wb (remote-exec):  2333 pts/0    S+     0:00 grep app.py
aws_instance.wb (remote-exec):  2335 pts/0    R+     0:00 python /app/helloworld/app.py
aws_instance.wb: Creation complete after 2m14s (ID: i-0d53f5b33bd3fe9b9)

Apply complete! Resources: 21 added, 0 changed, 0 destroyed.

Outputs:

ec2_url = <your application public dns>


```

##### Step 5 :

* Open Browser and check the running application `<your application public dns>`


##### Step 6 :

* Open AWS console on the browser and check the created `EC2 ` Instance

##### Step 7 :
 
 * Run `terraform destroy` to remove services related to EC2 from AWS.
 
    1. It will ask you to enter **Region**
    2. It will ask permission to do the actions type `yes` and press enter to continue 
  
```commandline
root@ubuntu:~/Desktop/Labs/AWS-Security-Training/ec2/lab/without_vpc# terraform destroy
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Default: us-east-1
  Enter a value: 

tls_private_key.we45_test_key: Refreshing state... (ID: b16f9ca00f35bf6aab478a2bfa77d52c77ff1e4a)
random_string.random_name: Refreshing state... (ID: none)
local_file.aws_key: Refreshing state... (ID: d11b6d43298c8fd73b445e447c9e300aafada98e)
 aws_subnet.public-subnet

  - aws_vpc.stack-example-vpc

  - local_file.aws_key

  - random_string.random_name

  - tls_private_key.we45_test_key


Plan: 0 to add, 0 to change, 21 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

local_file.aws_key: Destroying... (ID: d11b6d43298c8fd73b445e447c9e300aafada98e)
local_file.aws_key: Destruction complete after 0s
aws_route_table_association.private-subnet: Destroying... (ID: rtbassoc-0366a302e20bd1b69)
aws_instance.wb: Destroying... (ID: i-0d53f5b33bd3fe9b9)
aws_route_table_association.public-subnet: Destroying... (ID: rtbassoc-0c0a787e3dffaa901)
aws_route_table_association.private-subnet: Destruction complete after 1s
aws_route_table.private-route: Destroying... (ID: rtb-03b5f7f0a788a6574)
aws_security_group.internet_ssh: Destroying... (ID: sg-0215853f92ecf638c)
aws_key_pair.generated_key: Destroying... (ID: we45_cloudwatch)
aws_key_pair.generated_key: Destruction complete after 1s
tls_private_key.we45_test_key: Destroying... (ID: b16f9ca00f35bf6aab478a2bfa77d52c77ff1e4a)
tls_private_key.we45_test_key: Destruction complete after 0s
aws_subnet.public-subnet: Destruction complete after 2s
aws_security_group.internet_ssh: Destruction complete after 2s
aws_vpc.stack-example-vpc: Destroying... (ID: vpc-0f83625d81b8d664b)
aws_vpc.stack-example-vpc: Destruction complete after 1s
random_string.random_name: Destroying... (ID: none)
random_string.random_name: Destruction complete after 0s

Destroy complete! Resources: 21 destroyed.

  
```
