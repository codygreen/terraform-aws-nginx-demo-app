# NGNIX Demo App Terraform Module
Terraform module to deploy a lightweight demo application from NGINX

![hello](https://github.com/nginxinc/NGINX-Demos/raw/master/nginx-hello/hello.png)

## Example
```hcl
module aws-nginx-demo {
  source  = "codygreen/nginx-demo-app/aws"
  version = "0.1.2"

  prefix                 = "nginx-demo-app"
  ec2_key_name           = "my-key"
  vpc_security_group_ids = [sg-01234567890abcdef]
  vpc_subnet_ids         = [subnet-01234567890abcdef]
}
```
## Access Instance
To access the instance via SSH you will need to use the private key referenced in the deployment under the ec2_key_name variable.  

**Note:** The example below uses an IP address that will be different from the IP address assigned to your instances 
```bash
ssh -i ~/.ssh/my-key ubuntu@18.219.222.201
```