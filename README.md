# NGNIX Demo App Terraform Module
Terraform module to deploy a lightweight demo application from NGINX

![hello](https://github.com/nginxinc/NGINX-Demos/raw/master/nginx-hello/hello.png)

## Example
```hcl
module aws-nginx-demo {
  source  = "app.terraform.io/f5cloudsa/nginx-demo-app/aws"
  version = "0.1.0"

  prefix                 = "nginx-demo-app"
  ec2_key_name           = "my-key"
  vpc_security_group_ids = [sg-01234567890abcdef]
  vpc_subnet_ids         = [subnet-01234567890abcdef]
}
```