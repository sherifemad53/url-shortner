# LocalURL_Shortner_Platform

## Overview

This project is a simple URL shortener platform designed to test and demonstrate skills in Docker, GitHub Actions, Kubernetes, and Terraform. It provides a web interface to shorten URLs and redirect users to the original links.

## Technologies Used

-   **Python & Flask**: The backend is built using Python and Flask, serving the web interface and handling URL shortening logic.
-   **Docker**: The application is containerized using Docker for easy deployment and environment consistency.
-   **GitHub Actions**: CI/CD pipelines are set up with GitHub Actions to automate testing, building, and deployment processes.
-   **Kubernetes**: The app is deployed on Kubernetes for orchestration, scalability, and management of containers. Manifests are provided in the `kubernetes/` directory.
-   **Terraform**: Infrastructure as Code (IaC) is managed using Terraform, allowing automated provisioning of cloud resources. Terraform files are in the `terraform/` directory.

## How It Works

1. **User Interface**: Users access a web page (served from `app/templates/index.html`) to submit URLs they want to shorten.
2. **Shortening Logic**: The backend generates a unique short code for each URL and stores the mapping.
3. **Redirection**: When a user visits the short URL, the backend redirects them to the original URL.

## Getting Started

### Prerequisites

-   Docker
-   Python 3.10+
-   (Optional) Kubernetes cluster (e.g., Minikube, Docker Desktop)
-   (Optional) Terraform and a supported cloud provider account

### Running Locally with Docker

1. Build the Docker image:
    ```cmd
    docker build -t url-shortener .
    ```
2. Run the container:
    ```cmd
    docker run -p 5000:5000 url-shortener
    ```
3. Access the app at [http://localhost:5000](http://localhost:5000)

### Running Locally without Docker

1. Install dependencies:
    ```cmd
    pip install -r app/requirements.txt
    ```
2. Run the app:
    ```cmd
    python app/main.py
    ```

### Deploying with Kubernetes

1. Apply the namespace, deployment, and service manifests:
    ```cmd
    kubectl apply -f kubernetes/namespaces.yaml
    kubectl apply -f kubernetes/deployment.yaml
    kubectl apply -f kubernetes/service.yaml
    ```
2. Access the service using the method appropriate for your cluster (e.g., port-forward, LoadBalancer, etc).

### Infrastructure with Terraform

1. Initialize Terraform:
    ```cmd
    cd terraform
    terraform init
    ```
2. Apply the configuration:
    ```cmd
    terraform apply
    ```

## CI/CD

-   GitHub Actions workflows automate testing, building, and deployment on code changes.

## Project Structure

- `app/` - Application source code and templates
-   `kubernetes/` - Kubernetes manifests
-   `terraform/` - Terraform IaC files
-   `Dockerfile` - Docker build instructions

## License

This project is for educational purposes.
