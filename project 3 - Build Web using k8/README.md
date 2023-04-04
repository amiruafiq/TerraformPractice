# Task project 3
## To create simple website using Azure kurbenetes by using Terraform 
1. xxx

## Terraform Command
1) terraform init (to initialize terraform)
2) terraform plan (system check what changes will happen)
3) terraform apply (apply the changes)
4) terraform destroy (delete all resources)
5) terraform state list (to list all available resources deployed)
6) terraform state show *aws_internet_gateway.id* (to show more detail on selected resources)

![This is an image](img/TerraformStateList.png)
![This is an image](img/TerraformStateShow.png)


## Steps to create K8
Creating a website in AWS Kubernetes with Terraform involves several steps:

Configure the Kubernetes cluster in AWS:

1) First, you need to create a Kubernetes cluster in AWS. You can use tools like EKS or Kops to do this.
Once the cluster is created, you can configure the necessary resources such as nodes, pods, services, and deployments.
Set up a container registry:

2) Next, you need to set up a container registry to store the application images. AWS provides a container registry called Amazon ECR that you can use.
Build and push the application image:

3) After the registry is set up, you need to build the application image and push it to the container registry.
Configure the Terraform code:

4) The next step is to configure the Terraform code. You need to create a Terraform script that specifies the necessary resources for deploying the website.
The Terraform script should include the Kubernetes cluster configuration, container registry configuration, and the deployment of the application.
Apply the Terraform script:

5) Once the Terraform script is configured, you can apply it to deploy the website. Terraform will create the necessary resources in the Kubernetes cluster and deploy the application.
Here are the high-level steps you can follow to create a website in AWS Kubernetes with Terraform. Keep in mind that the specific details of each step may vary depending on your requirements and preferences.