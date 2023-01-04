# Terraform


Terraform is an infrastructure automation platform for cloud provideres that deploys cloud resources in a repeatable, testable and auditable manner. I am developing terrform modules which deploy VPC, ALB, ACM, SG, EC2
![Terraform](https://content.hashicorp.com/api/assets?product=tutorials&version=main&asset=public%2Fimg%2Fterraform%2Fterraform-iac.png)


## Preparing the environment

1.	Clone repository to your local computer
2.	Install terraform and configured AWS credentials


## Deploying Cloud Infrastructure
Deploy dev infra for projectA: 

```
cd ./projectA/dev
terraform plan
terraform apply

```
Deploy prod infra for projectA:

```
cd ./projectA/prod
terraform plan
terraform apply

```


## Useful links:
1.	https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code
2.	https://registry.terraform.io/providers/hashicorp/aws/4.48.0