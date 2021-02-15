# What is RudderStack?

[RudderStack](https://rudderstack.com/) is a **customer data pipeline** tool for collecting, routing and processing data from your websites, apps, cloud tools, and data warehouse.

More information on RudderStack can be found [here](https://github.com/rudderlabs/rudder-server).

## RudderStack Server Infra Setup Guide

This section assumes you have Terraform installed on your machine, and you can configure the AWS CLI credentials. Please refer to the following documents if needed:

- https://docs.aws.amazon.com/en_pv/cli/latest/userguide/cli-chap-install.html,
- https://www.terraform.io/downloads.html

### Setting up your RudderStack account


1. Go to the [RudderStack dashboard](https://app.rudderstack.com) and set up your account. Copy your workspace token from top of the home page.
2. Replace `<your_workspace_token>` in `dataplane.env` with the above token.
3. Configure a new source and get the `<source_write_key>`. The `source_write_key` will be used later for basic authentication to send the events.

### Non-Default VPC

If you are launching the machine in a default VPC, please skip this step and move on to the next section.

If you don't have a default VPC or want to launch RudderStack in a non-default VPC, check out the branch `custom-vpc`. Fill in the variables `custom_vpc.vpc_id` and `custom_vpc.subnet_id` in `variables.tf` depending on where you want to launch.

### AWS setup with Terraform 

1. Create an AWS user with Administrator access and save your credentials in `~/.aws/credentials`. These credentials are only used by Terraform. We don't need Administrator access but it is easy to setup.

2. The AWS resources that we create is 1 EC2 key pair, 1 EC2 instance, 1 S3 bucket, 2 security groups (to open 22, 8080 ports) 1 IAM role and corresponding policy.

2. Create a SSH keypair. Store in any location (preferably in `~/.ssh/id_rsa_tf`, otherwise update new location in `variables.tf`). If you want to use your existing keypair, you can skip generating a new one and provide the path to that keypair.
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

3. Clone this repo.

4. Change the S3 bucket name in `variables.tf`, bucket names are global scoped. 
Change the `prefix` in `variables.tf`, if needed. 
If you get a conflict, you might have to use a different bucket name. You can also update EC2 type (default volume type is gp2), volume size (default volume size is 100GB), etc in the `variables.tf`

5. `terraform init`

6. `terraform apply` and Enter `yes` when prompted.

7. Jot down the `instance_ip` from output.

8. You can now send events to following endpoints with basic auth. Basic auth username would be the source key you got earlier
and empty password.
```
http://<instance_ip>:8080/v1/track
http://<instance_ip>:8080/v1/identify
http://<instance_ip>:8080/v1/page
http://<instance_ip>:8080/v1/screen
http://<instance_ip>:8080/v1/batch
```


### Create a S3 destination

1. Configure a new S3 destination and give the bucket name that you created as part of Terraform setup.

### Test your setup

1. Save your event data in a JSON file, say `event.json` (A sample `event.json` has been included in the repo)

2. Make the following curl request to send an event
```
curl -u <source_write_key>: -X POST http://<instance_ip>:8080/v1/track -d @event.json --header "Content-Type: application/json"
```

## Contact Us

If you come across any issues while following the steps in this guide, please feel free to [contact us](https://rudderstack.com/contact/) or start a conversation on our [Slack](https://resources.rudderstack.com/join-rudderstack-slack) channel. We will be happy to help you.


