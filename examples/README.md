# New NGINX demo app in each each AZ
This examples deploys a new VPC and builds 2 NGINX demo apps in each availability zones

## Usage
To run this example run the following commands:
```bash
terraform init
terraform plan
terraform apply --auto-approve 
```

**Note:** this examples deploys resources that will cost money.  Please run the following command to destroy your environment when finished:
```bash
terraform destroy --auto-approve
```