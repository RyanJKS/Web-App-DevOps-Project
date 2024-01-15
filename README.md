# Web App Azure DevOps

## Table of Contents
1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Web Application](#web-application)
    - [Tech Stack](#technology-stack)
4. [Getting Started](#getting-started)
    - [Version Control with GIT](#version-control-with-git)
    - [Dockerization](#dockerization)
    - [Infrastructure as Code with Terraform](#infrastructure-as-code-with-terraform)
    - [Kubernetes Orchestration](#kubernetes-orchestration)
    - [Azure DevOps CI/CD Pipeline](#azure-devops-cicd-pipeline)
    - [Monitoring and Alerts for AKS Cluster](#monitoring-and-alerts-for-aks-cluster)
    - [Security Measures: Integration with Azure Key Vault](#security-measures-integration-with-azure-key-vault)
5. [Application Usage](#application-usage)
6. [File Structure](#file-structure)
7. [Contributors](#contributors)
8. [License](#license)

## Overview
I have taken on a pivotal role in creating a sophisticated DevOps pipeline for a company's vital web application—a system integral to orchestrating and overseeing their delivery operations. This transformative project is about evolving a small-scale web app into a robust and collaborative development environment, setting the stage for it to flourish within a globally expansive company structure.

The journey begins with the existing company application, available in its [original repository](https://github.com/maya-a-iuga/Web-App-DevOps-Project). It serves as the foundation from which we will construct a multi-layered and service-intensive application lifecycle.

### Transformation Objectives:
1. **Version Control Integration:** By integrating Git, we foster a collaborative platform that enables multiple developers to contribute effectively, maintaining the integrity and consistency of the application's codebase.

2. **Containerization with Docker:** We streamline the app's deployment by packaging it with Docker, enhancing its portability across diverse operational ecosystems, with Docker Hub serving as the hub for our container registry.

3. **Infrastructure as Code (IaC):** Utilizing Terraform, we'll define and orchestrate Azure resources, laying down a reliable and replicable infrastructure framework.

4. **Kubernetes Orchestration**: The application's deployment and scaling are managed by Kubernetes, assuring dependable and efficient operation under varying loads.

5. **Azure DevOps CI/CD Pipeline Construction:** Implementing CI/CD principles, the build and deployment processes are automated, accelerating the development cycle and bolstering the reliability of releases.

## Architecture
The architecture of our DevOps pipeline is designed to be resilient, scalable, and secure, as depicted in the diagram provided.

<div align="center">
  <img src="/images/architecture.png" alt="orders-list">
</div>

### Workflow Steps:
1. **Build Environment:** Using **Terraform** as our **Infrastructure as Code (IaC)** solution, we define our cloud infrastructure, setting the stage for a repeatable and consistent environment setup.

2. **Commit:** Developers commit code changes to the version control system, which in this case, is managed by **Git**, ensuring that every change is tracked and reversible.

3. **Pull Secrets:** **Azure Key Vaults** securely manage secrets, tokens, and certificates, ensuring sensitive information is never exposed in the codebase.

4. **Build Containers: Azure Pipelines** compile the application into a Docker container, transforming code into a deployable unit.

5. **Push Containers:** The Docker images are pushed to **Docker Hub Container Registry**, where they are stored and versioned.

6. **Deploy Application:** Containers are pulled from the registry and deployed to the **Azure Kubernetes Services (AKS) Cluster**, where the application is brought to life.

7. **Monitor Application:** The deployment is continuously monitored using **Azure Monitor**, **Application Insights**, and **Log Analytics** Workspaces. This comprehensive monitoring suite allows for proactive issue resolution and performance optimization.

## Web Application
The application consists of an interface designed for managing and monitoring company deliveries, complete with a pagination feature that enhances order visibility. It also includes a form-based system for adding new orders, which are then immediately visible on the home page, ensuring real-time updates within the application.

The application consists of:

1. **Order List Page:** View all existing orders and navigate using pagination controls.

<div align="center">
  <img src="/images/web-app/orders-list.png" alt="orders-list">
</div>

2. **Add New Order Page:** Access the order form to add new orders. Complete all required fields with valid entries.

<div align="center">
  <img src="/images/web-app/new-orders.png" alt="new-orders">
</div>

### Technology Stack
- **Frontend:** HTML, CSS, and JavaScript for a user-friendly interface.
- **Backend:** Flask for backend operations, routing, data processing, and database interactions.
- **Database:** Azure SQL Database for storing order data.

## Getting Started

### Version Control with GIT
Version control is a cornerstone of modern software development, enabling teams to track changes, collaborate, and maintain the history of a project. For this project, GitHub was chosen as the repository to host our application due to its robust features for version control and collaboration.

1. **Issue Tracking**
Issues on GitHub allow us to track enhancements like adding new database fields, fostering clear communication among team members.

2. **Branching for Feature Development**
Branching is essential for parallel development, enabling us to work on new features such as feature/add-delivery-date without impacting the main codebase.

3. **Pull Requests for Integration**
Pull requests facilitate the review and integration of new features into the main branch, ensuring that every code change is scrutinized and approved.

4. **Reverting Changes**
When necessary, we can revert changes using the git revert command, maintaining the integrity of the main branch.
    ```sh
    git revert <COMMIT_HASH>
    ```

### Dockerization
During the Dockerization phase, we encapsulated our company's internal application within Docker containers. This ensures that our application is not only accessible to different teams but also maintains a consistent environment across various development setups.

#### Containerization Process
A `Dockerfile` was crafted, detailing each layer and the environment setup required to run our application. This Dockerfile is critical for defining the container and ensuring that every instance of our application runs exactly as expected.

#### Docker Commands
We have documented the Docker commands that were integral to our workflow. This includes commands for:

- **Building the Docker image:**
  ```sh
  docker build -t flask-web-app:latest .
  ```
- **Running the container locally:**
    ```sh
    docker run -d -p 5000:5000 flask-web-app:latest
    ```
  > If the container is running successfully, it should be accessible via `localhost:5000` or  `http://127.0.0.1:5000`.
- **Tagging the image for release:**
    ```sh
    docker tag flask-web-app:latest ryanjks/flask-web-app:latest
    ```
- **Pushing the image to Docker Hub:**
    ```sh
    docker push username/flask-web-app:latest
    ```

**Image Information**
We maintain detailed records of the Docker image specifications, including its name (`flask-web-app`), tag (`latest`), and any special configurations. The image is designed to be portable and self-contained, bundling all necessary dependencies.

#### Cleanup
- **Remove Containers**: Using `docker ps -a`, we list all containers and remove the ones that are no longer needed with `docker rm <container-id>`.

- **Remove Images**: To free up disk space, we list all Docker images with `docker images -a` and remove the unnecessary ones using `docker rmi <image-id>`.

### Infrastructure as Code with Terraform
This project utilizes Terraform to define, provision, and manage the Azure infrastructure necessary for deploying and managing an Azure Kubernetes Service (AKS) cluster. 

The workflow of provisioning starts by setting up the networking environment that will house the AKS cluster. Once networking is ready, we deploy the AKS cluster into this environment, leveraging the networking setup to secure and connect our Kubernetes workloads.

By orchestrating the provisioning process with Terraform, we ensure that each component is built in the correct order and configuration. This modular setup not only makes the infrastructure management more manageable but also allows for reusable components across different environments or projects.

#### Prerequisites for Terraform with Azure
Before beginning with Terraform, you need to have the following prerequisites in place:

- An active Azure account with a subscription.
- Azure CLI installed on your local machine.
- A service principal created via Azure CLI to authenticate Terraform, which can be done with the command:
  
  ```sh
  az ad sp create-for-rbac -n <service-principal-name> --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"

  ```
> Replace `YOUR_SUBSCRIPTION_ID` with your actual subscription ID. 

| :exclamation:  This is very important   |
|-----------------------------------------|
> Securely store the output from creating the service principal. Terraform will use these credentials to authenticate with Azure services and it should be referenced when running Terraform commands. The credentials should be:
>  - Service Principal ID (Client ID)
>  - Service Principal Secret (Client Secret)
>  - Tenant ID
>  - Subscription ID

#### Networking Module (`networking-module`)
The networking module lays the groundwork for the AKS cluster's network architecture. It is responsible for setting up:

- **Azure Resource Group**: A container that holds related resources for our AKS solution. This is where all network components are logically grouped, which simplifies resource management and provides clear boundaries for billing and access control.
  
- **Virtual Network (VNet) and Subnets**: The backbone of our cluster's network. VNets provide isolation from other networks in Azure while subnets allow us to segment the VNet into smaller networks that can be dedicated to particular uses, like the control plane and worker nodes. This segregation enhances security and traffic management within the cluster.

- **Network Security Group (NSG)**: Acts as a virtual firewall for our subnets, defining rules that allow or deny network traffic to and from resources. We use NSGs to strictly regulate access to the AKS cluster, ensuring that only traffic from specified IP addresses (such as our public IP) can reach the management and node endpoints.

The networking module is provisioned first to ensure that the core networking foundation is in place before the AKS cluster is deployed.

#### AKS Cluster Module (`aks-cluster-module`)
With the networking infrastructure in place, the AKS cluster module provisions:

- **AKS Cluster**: The managed Kubernetes service that offers powerful cluster management and orchestration. It is the central piece of our containerized application deployment strategy, enabling us to run and scale applications with ease.
  
- **Service Principal**: An identity that the AKS cluster uses to interact with other Azure services under the security context provided. It allows AKS to securely manage resources like load balancers and managed disks on behalf of the application it runs.

- **Node Pools**: These are groups of nodes within the AKS cluster, where each node is an Azure Virtual Machine that runs the Kubernetes node components. The module configures node pools with auto-scaling enabled, which allows our cluster to adapt resource allocation based on demand automatically.

The AKS cluster module relies on the networking module's output to integrate the cluster with the established VNet and subnets, ensuring the cluster's components are correctly placed within our private network architecture.

> Run `terraform init` within modules to initialize the directory with necessary configurations and to download any required provider plugins for Terraform.

#### Root Terraform Configuration (`aks-terraform`)
At the root level, our Terraform configuration ties together the provider setup and module integration.

- **Provider Configuration**: We define the Azure provider and its required version, ensuring we use a specific provider version for consistency across deployments.
  
- **Module Integration**: Here, we bring together the networking and AKS modules. By specifying the source paths and passing the necessary input variables, we establish a dependency chain. The networking module's resources are created first, followed by the AKS cluster, which utilizes those resources.

Run the following commands in order to setup the infrastructure on Azure:
```sh
terraform init
terraform plan
terraform apply
```

### Kubernetes Orchestration
With the necessary infrastructure in place, the next critical task was to proceed with the deployment of the containerized application to the Kubernetes Cluster on Azure. To achieve this, a Kubernetes manifest file (`application-manifest.yaml`) was created, which defines the desired state of our application in the Kubernetes cluster.

#### Deployment and Service Manifests
For deploying our web application to the Kubernetes Cluster on Azure, I defined two key components in our manifest.yaml: the Deployment and Service manifests.

- **Deployment Manifest**: This part of the manifest outlines how our application's Pods should be created and managed. This configuration ensures that our application remains consistently available and scalable.
  - **Replicas:** Set to 2, ensuring redundancy and load distribution.
  - **Image:** `ryanjks/flask-web-app:latest`, specifying the Docker image for the Pods.
  - **Container Port:** 5000, where the application listens for traffic.

- **Service Manifest**: The Service manifest establishes a stable network interface for interacting with the application. By configuring it as a **ClusterIP service**, we expose our application internally within the cluster on a stable IP address. The service listens on **port 80** and routes traffic to **port 5000** on the Pods. This setup enables internal communication and load balancing across the application's replicas.

#### Deployment Strategy
For updating the application within our Kubernetes environment, we've chosen a **RollingUpdate** strategy. This approach:

- Ensures zero downtime by gradually replacing old Pods with new ones.
- Maintains service availability as the update progresses.
- Allows for a controlled roll-out, minimizing the impact of any potential issues.

This strategy aligns well with our need for high availability and seamless updates, which are crucial for maintaining a consistent and reliable service for the application.

#### Testing and Validation
Post-deployment, we conducted several tests to validate the functionality and reliability of the application within the AKS cluster using the following commands:

1. **Merge Cluster:** Ensure that the AKS cluster has been merged to your local `.kube` file such that you can have access to it.
    ```sh
    az aks get-credentials --resource-group [resource_group_name] --name [aks_cluster_name]
    ```
2. **Check Current Context**: Ensure you're operating in the correct Kubernetes context.`
    ```sh
    kubectl config current-context
    ```
3. **Switch Context:** If necessary, switch to the correct Kubernetes cluster context.
    ```sh
    kubectl config use-context [your-aks-cluster-context]
    ```
4. **Get Deployments:** Check the status of your deployments.
    ```sh
    kubectl get deployments
    ```
5. **Get Services:** Verify that the service is running and note the internal IP.
    ```sh
    kubectl get services
    ```
6. **Port Forwarding:** For local testing, you can forward a local port to a port on the Pod.
    ```sh
    kubectl port-forward [pod-name] 5000:5000
    ```

#### Application Distribution and Access
**Internal Access**

For internal distribution to other users within the organization without relying on port forwarding, the following steps and Kubernetes mechanisms are used:

1. **Internal DNS or Ingress Controller Setup:**
    - Deploy an Ingress Controller in the cluster.
    - Configure an Ingress resource to expose the internal service.

2. **Role-Based Access Control (RBAC):**
    - Define roles and role bindings to control which internal users or groups can access the application. 

3. **Internal Service Exposure:**
    - If not using Ingress, expose the application as a ClusterIP service (default) to make it accessible within the organization's network.


**External Access**
To share the application with external users, the following steps are undertaken:
1. **External Ingress or Load Balancer:**
    - Create an external Load Balancer.
    ```sh
    kubectl expose deployment flask-app-deployment --type=LoadBalancer --name=flask-app-service
    ```
    - Alternatively, set up an external-facing Ingress resource with appropriate annotations for HTTPS and external access.

2. **Authentication and Authorization:**

    - Implement an authentication mechanism, possibly integrating with external identity providers like OAuth or SAML.

3. **Secure Access:**
    - Ensure TLS/SSL encryption for secure communication. This can be configured in the Ingress resource.
    - Apply network policies for additional security, controlling the traffic to and from the application.

### Azure DevOps CI/CD Pipeline

#### Pipeline Setup and Source Repository Configuration

- **Azure DevOps Project:** A new project was created in Azure DevOps, linked to the Azure account used for this project.
- **Source Repository:** The pipeline is configured with GitHub as the source control system. The repository hosting our application code serves as the trigger point for the CI/CD process.

#### Build Pipeline Configuration
- **Build Trigger:** The pipeline triggers automatically on any push to the main branch of the GitHub repository.
- **Docker Hub Integration:** A service connection between Azure DevOps and Docker Hub was established using a personal access token created on Docker Hub.
- **Docker Build and Push:** A Docker task is included to build the application image and push it to Docker Hub, using the same image name and tagging conventions as in the local development environment.

#### Release Pipeline and Integration
- **Azure Resource Manager Connection (AKS Integration)**: Establish a connection to Azure using the Service Principal (Manual) in order to connect to the AKS cluster.
- **Deployment Configuration:** The pipeline is configured with a **Deploy to Kubernetes** task using the `kubectl deploy` command, targeting the AKS cluster. This task deploys the application using the Kubernetes manifest file from our source repository.

#### Validation and Testing of the CI/CD Pipeline
- **Pod Status Check:** Post-deployment, the status of Pods within the AKS cluster was monitored using the command the following command to ensure they were correctly created and running.
  ```sh
  kubectl get pods
  ```
- **Port Forwarding:** To validate the application’s functionality, port forwarding was set up using the following command to access the application running on AKS from a local environment.
  ```sh
  kubectl port-forward <pod-name> 5000:5000
  ```

## Monitoring and Alerts for AKS Cluster
The monitoring and alerting setup for the AKS cluster is a crucial aspect of our DevOps pipeline. It ensures that the cluster operates efficiently and that any potential issues are identified and addressed promptly.

### Metrics Explorer Charts
For comprehensive monitoring, the following charts were set up in Metrics Explorer:

1. **Average Node CPU Usage:**

    - **Significance:** Tracks the CPU usage across all nodes in the AKS cluster.
    - **Interpretation:** Helps in identifying nodes with high CPU usage which could indicate a need for scaling or optimization.

<div align="center">
  <img src="/images/aks-cluster-metrics/avg-node-cpu-usage.png" alt="Average Node CPU Usage Chart">
</div>

2. **Average Pod Count:**
    - **Significance:** Shows the average number of pods running in the cluster.
    - **Interpretation:** Useful for understanding the cluster's workload and capacity utilization.
  
<div align="center">
  <img src="/images/aks-cluster-metrics/avg-pod-count.png" alt="Average Pod Count Chart">
</div>

3. **Used Disk Percentage:**

    - **Significance:** Indicates the percentage of disk space utilized.
    - **Interpretation:** Critical for preventing storage-related issues by proactive monitoring.

<div align="center">
  <img src="/images/aks-cluster-metrics/used-dick-perc.png" alt="Used Disk Percentage Chart">
</div>

4. **Bytes Read and Written per Second:**

    - **Significance:** Provides insights into the data transfer rates in and out of storage devices.
    - **Interpretation:** Aids in identifying potential I/O bottlenecks.

<div align="center">
  <img src="/images/aks-cluster-metrics/read-write-psecond.png" alt="Data IO Chart">
</div>

Each of these charts provides specific insights, aiding in the efficient management of cluster resources.

### Log Analytics
Several key log configurations are employed:

1. **Average Node CPU and Memory Usage:**
    - Captures detailed data on node-level resource usage, crucial for identifying performance issues.
    - An example query is already defined within Azure which can be accessed on the portal.

2. **Pods Counts with Phase:**
    - Provides an overview of pod distribution across different lifecycle phases.
    - An example query is already defined within Azure which can be accessed on the portal.

3. **Find Warning Value in Container Logs:**
    - Detects warning signals within container logs, aiding in early issue identification.
    - Sample Log Entry: 
    
<div align="center">
  <img src="/images/log-analytics/find-warning.png" alt="Warning Value Log">
</div>

4. **Monitoring Kubernetes Events:**
    - Tracks key events within the Kubernetes environment for overall health assessment.
    - Sample Log Entry: 
   
<div align="center">
  <img src="/images/log-analytics/monitoring-kubernetes.png" alt=" Kubernetes Events Log">
</div>

### Alert Configuration
Alerts have been set up to ensure proactive issue resolution:

1. **Disk Usage Alert:**
    - **Configuration:** Triggers when disk usage exceeds 90%.
    - **Frequency and Notification:** Checks every 5 minutes, with a 15-minute loopback. Notifications are sent via email.

2. **CPU and Memory Usage Alerts:**
    - **Configuration:** Set to trigger when resource usage exceeds 80%.
    - **Purpose:** Alerts of high resource consumption, potentially impacting application performance.

### Response Strategies to Alarms
In response to triggered alarms:

1. **Scaling Resources:** Evaluate whether scaling the cluster (up or out) is required.
2. **Resource Allocation:** Adjust resource limits and requests for Pods to optimize usage.
3. **Troubleshooting:** Investigate logs and metrics to identify the root cause of the alert.
4. **Maintaining Efficiency:** Continuously monitor the cluster's performance and adjust configurations to ensure optimal operation.

The monitoring and alerting system is a dynamic and critical component of our AKS cluster management, ensuring the application's availability, performance, and reliability. The strategies and tools implemented are key to maintaining the operational efficiency of the AKS cluster.

## Security Measures: Integration with Azure Key Vault
As part of enhancing the security measures for the company's application, especially regarding the handling of database credentials, significant steps have been taken to integrate Azure Key Vault for secure secrets management. This section details these steps and their implementation.

### Azure Key Vault Setup and Permissions
1. **Creation of Azure Key Vault:**
    - Established an Azure Key Vault to securely store sensitive information, such as database credentials.
2. **Permissions Assignment:**
     - Assigned the Key Vault Administrator role to my Microsoft Entra ID user, granting full management capabilities over the Key Vault.

### Secrets Management in Key Vault
1. **Storing Secrets:**
    - Created four secrets within the Key Vault corresponding to the database credentials: server name, username, password, and database name. These replace the hardcoded values in the application code.

2. **Secrets Usage:**
    - Each secret in the Key Vault directly corresponds to a specific credential required by the application to establish a secure connection to the Azure SQL Database.

### AKS Integration with Key Vault
1. **Managed Identity for AKS:**
    - Enabled a managed identity for the AKS cluster, facilitating secure interactions with Azure Key Vault without storing credentials in the application.
        ```sh
        az aks update --resource-group <resource-group> --name <aks-cluster-name> --enable-managed-identity
        ```
    - (Optional): You might require to update your node pool as well in order to make the cluster become full system managed. Use the following command:
        ```sh
        az aks nodepool upgrade --resource-group <resource-group> --cluster-name <aks-cluster-name> --name <nodepool-name>
        ```
    - Make a note of the clientID from the ouput of the query below:
        ```sh
        az aks show --resource-group <resource-group> --name <aks-cluster-name> --query identityProfile
        ```

2. **Permission Assignment to Managed Identity:**

    - The managed identity associated with the AKS cluster was granted the Key Vault Secrets Officer role, allowing it to retrieve and manage secrets stored in Key Vault.
        ```sh
        az role assignment create --role "Key Vault Secrets Officer" \
        --assignee <managed-identity-client-id> \
        --scope /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.KeyVault/vaults/{key-vault-name}
        ```

### Testing and Deployment
1. **Local Testing:**
    - Executed `docker-compose up` to build and run the application, ensuring the Key Vault secrets were correctly retrieved and used by the application.

2. **Deployment via CI/CD Pipeline:**
    - Deployed the updated application to the AKS cluster using the existing Azure DevOps CI/CD pipeline.

3. **End-to-End Testing in AKS:**
    - Utilized `kubectl get pods` to check the status of the deployment and `kubectl port-forward` to test the application's connectivity and functionality.

This integration with Azure Key Vault significantly elevates the security posture of our application by securely managing sensitive database credentials and eliminating the risks associated with hardcoded information. The managed identity approach ensures that the AKS cluster securely retrieves these credentials, maintaining the overall integrity and security of the application.

## Application Usage
This section guides developers on how to add new features to the application and deploy them to the production environment through the established DevOps pipeline.

#### Reporting and Tracking Changes

1. **Create an Issue for Feature Tracking:**
    - Fork this repository to your local machine.
    - Click the 'Issues' tab and select 'New Issue'.
    - Title it descriptively, e.g., "Add delivery_date column", and detail the feature's requirements.
    - Submit the issue to track the development of this new feature.

#### Feature Development and Branching
1. **Create a New Feature Branch:**
    - Ensure you're on the main branch: 
        ```sh
        git checkout main
        ```
    - Create a new branch: 
        ```sh
        git checkout -b feature/add-delivery-date.
        ```

2. **Develop the New Feature:**
    - Update necessary files (e.g., app.py, orders.html) to incorporate the delivery_date column.
    - Test your changes locally to ensure functionality.

3. **Push Changes to Remote Repository:**

    - Add your changes: 
        ```sh
        git add .
        ```
    - Commit with a meaningful message: 
        ```sh
        git commit -m "Add delivery_date column to tracking."
        ```
    - Push to remote: 
        ```sh
        git push origin feature/add-delivery-date.
        ```
#### Integrating Changes via Pull Request
1. **Submit a Pull Request:**
    - Navigate to your GitHub repository.
    - Go to the 'Pull Requests' tab and select 'New Pull Request'.
    - Choose `main` as the base branch and `feature/add-delivery-date` as the compare branch.
    - Review changes, add a descriptive title and details.
    - Submit the pull request for review.

2. **Review and Merge the Pull Request:**
    - Navigate to the PR, review the changes and discussions.
    - As a reviewer, ensure all is in order, then merge the PR: `Click Merge Pull Request`, then confirm the merge.

#### Post-Merge Actions and Verification
1. **Monitor the DevOps Pipeline:**
    - Observe the automated CI/CD pipeline triggered by the merge.
    - Check the build and deployment status in Azure DevOps.

2. **Verify Deployment on Production:**
    - Access the Kubernetes cluster: 
        ```sh
        kubectl get pods
        ```
    - Check for the updated pod running the latest changes.
    - Verify the feature is live and functioning as expected in the production environment by using port-forwarding using the pod name.

This workflow ensures that new features are developed, reviewed, and deployed systematically, maintaining the integrity and continuity of the application in the production environment.

## File Structure

```bash
|- aks-terraform/
    |- aks-cluster-module/
        |- main.tf
        |- outputs.tf
        |- variables.tf
    | - networking-module/
        |- main.tf
        |- outputs.tf
        |- variables.tf
    | - main.tf
    | - variables.tf
|- images/
|- kubernetes-manifest/
    |-- application-manifest.yaml
|- static/
|- templates/
    | - orders.html
|- .gitignore
|- app.py
|- Dockerfile
|- LICENSE
|- README.md
|- requirements.txt
```


## Contributors
- [Maya Iuga](https://github.com/maya-a-iuga)

## License
This project is licensed under the MIT License. For details, refer to the [LICENSE](LICENSE) file.