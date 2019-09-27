#### **Rudder server infra set-up guide**

---

Pre-requisites : [Aws cli][1], [Terraform][2].
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

#### **Infra Setup**

1. Create your account with [Rudder labs][3]. Copy the token and use it as CONFIG_BACKEND_TOKEN in dataplane.env file.

2. `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

3. Enter file in which to save the key (/Users/\$user/.ssh/id_rsa): `id_rsa_tf`.
   And proceed with the default options.

4. `git clone git@github.com:rudderlabs/rudder-webapp.git; cd/rudder-webapp`

5. `terraform init`

6. `terraform apply` and Enter `yes` when prompted.

7. Jot down the `instance_ip` from output.

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

#### **Test your setup**

1.

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Helpful links -
https://docs.aws.amazon.com/en_pv/cli/latest/userguide/cli-chap-install.html,
https://www.terraform.io/downloads.html
[1]: https://docs.aws.amazon.com/en_pv/cli/latest/userguide/cli-chap-install.html "Aws cli install guide"
[2]: https://www.terraform.io/downloads.html "Terraform setup guide"

[3]: https://app.rudderlabs.com/ "app.rudderlabs.com"
