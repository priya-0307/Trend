# Trend Application Deployment Project

## Project Overview
This project demonstrates the end-to-end deployment of a sample React/Node.js application named **Trend** using **Docker**, **Terraform**, **AWS EKS**, and **Jenkins CI/CD**.  
The setup includes automated build, containerization, infrastructure provisioning, deployment to Kubernetes, and monitoring of the application.

---

cd Trend
The application runs on port 3000.

Ensure Node.js dependencies are installed:
--> npm install
--> npm start

Docker (Run Locally)

Dockerize the application by creating a Dockerfile.
--> docker build -t trend-app:latest .

Run Docker container:
--> docker run -p 3000:3000 trend-app:latest


Terraform

Infrastructure as Code setup using main.tf to provision:

VPC, subnets, internet gateway

IAM roles & policies

EC2 instance with Jenkins

Provision infrastructure:

--> terraform init
--> terraform plan
--> terraform apply

Kubernetes (EKS)
Setup AWS EKS cluster:

--> aws eks create-cluster --name my-eks-cluster --region ap-south-1 --kubernetes-version 1.27
Configure kubeconfig:

aws eks update-kubeconfig --name my-eks-cluster --region ap-south-1
Write Deployment and Service YAML files for the Trend application.

Apply manifests using kubectl:


kubectl apply -f trend-deployment.yaml
kubectl apply -f trend-service.yaml
Confirm pods and services:

kubectl get pods
kubectl get svc 

Jenkins CI/CD

Install Jenkins and required plugins:

Docker, Git, Kubernetes, Pipeline

Setup GitHub webhook for automatic build on every commit.

Pipeline Script (Declarative):

Build Docker image

Push to DockerHub

Deploy to Kubernetes via kubectl


Version Control
Use Git to manage code:
git init
git add .
git commit -m "Initial commit"
git push origin main
Include .gitignore to exclude unnecessary files.

Monitoring (Open Source)
Prometheus + Grafana + Loki for cluster and app monitoring.




