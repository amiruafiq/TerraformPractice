# Configure the AWS provider
provider "aws" {
  region = "us-west-2"
  access_key = "xx"
  secret_key = "xxx"  
}

# Create a Kubernetes cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  
  cluster_name = "my-cluster"
  subnets      = ["subnet-xxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyy", "subnet-zzzzzzzzzzzzzz"]
  vpc_id       = "vpc-xxxxxxxxxxxxxxxxx"
}

# Deploy a simple website to the Kubernetes cluster
resource "kubernetes_deployment" "website" {
  metadata {
    name = "website"
    labels = {
      app = "website"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "website"
      }
    }

    template {
      metadata {
        labels = {
          app = "website"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "website"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Expose the website using a LoadBalancer service
resource "kubernetes_service" "website_lb" {
  metadata {
    name = "website-lb"
  }

  spec {
    selector = {
      app = kubernetes_deployment.website.spec.0.template.0.metadata.0.labels.app
    }

    port {
      name        = "http"
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }

  depends_on = [
    kubernetes_deployment.website
  ]
}

# Note that this code assumes that you have already set up your AWS credentials 
# and that you have created the necessary subnets and VPC for your EKS cluster. 
# Also, you may need to modify the region, subnets, and VPC ID based on your specific setup.