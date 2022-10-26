# TerraformPractice
Step by step on terraform deployment

## Creating Resources on Cloud

```
resource "<providers>_<resource_type>" "name"{
    config option ...
    key = "value"
    key = "another value"
 }
```

For resource_type please find at Terraform website 
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

## Terraform Command
1) terraform init (to initialize terraform)
2) terraform plan (system check what changes will happen)
3) terraform apply (apply the changes)
4) terraform destroy (delete all resources)

### Create Intance / EC2
```
 #Create EC2
resource "aws_instance" "my-first-terraform-server" {
  ami           = "ami-0f62d9254ca98e1aa" #Amazon Linux 2 Kernel 5.10 AMI 2.0.20220912.1 x86_64 HVM gp2
  instance_type = "t2.micro"
  tags = {
    Name = "ubuntu"
    Project = "testing terraform"
    Owner = "Afiq Kurshid"
  }
  }
  ```

  ### Create VPC

  resource "resource_type" "name" {
  cidr_block = "10.0.0.0/16"
}
For resource_type please find at Terraform website 
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association

```
#Create VPC 
resource "aws_vpc" "first-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Production"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.first-vpc.id #refer to line 8
  cidr_block = "10.0.1.0/24"
  tags = {
    "Name" = "prod-subnet"
  }
  
}
```
*it will create subnet (prod-subnet) within VPC (Production) created

### Terrafrom Folder
1) .terraform / providers / registry.terraform.io / ...
Will appear after "terrform init". All plugin related to provider (AWS, Azure) will appear here.

2) terraform.tftstate
State of instructure. All resource will be here for Terraform to keep track
example: EC2, VPC, subnet (all information will be here)

<Put image 1 here>

Refer

[Terraform Course - Automate your AWS cloud infrastructure](https://www.youtube.com/watch?v=SLB_c_ayRMo&t=3179s&ab_channel=freeCodeCamp.org)
https://www.youtube.com/watch?v=SLB_c_ayRMo&t=3179s&ab_channel=freeCodeCamp.org

