Terraform
# Infrastructure as code
## Problem with manual configuration
Manual configuration of cloud infastructe allows you easily start using service offerings however there are downsides to this approach:
* It is hard to reproduce the same configuration in different environments
* It is hard to track changes in configuration
* It is hard to share configuration with other team members
* It is hard to automate configuration changes
* It is hard to recover from disaster
* It is hard to scale
and many more...

## Solution to the problem
Infrastructure as code is a process of managing and provisioning computing infrastructure and configuration through machine-readable definition files, rather than physical hardware configuration or the use of interactive configuration tools.
* IaC is a blueprint of your infrastructure
* IaC is a version controlled
* IaC is shareable and reproducable

## IaC tools
### Declaritive tools
* What you see is what you get. EXPLICIT.
* More verbose, but easier to read and understand.
* Uses scripting languages like YAML, JSON, HCL.
* Examples:
  * Terraform
  * CloudFormation - AWS
  * Cloud Deployment Manager - GCP
  * Azure Blueprints - Azure
  * ARM Templates - Azure

### Imperative tools
* You say what you want, and the rest is taken care of. IMPLICIT.
* Less verbose, but harder to read and understand.
* Uses scripting languages like Python, Ruby, Go, etc.
* Examples:
  * AWS Cloud Development Kit (CDK)
  * Pulumi
  * Ansible

### Choosing between imperative and declaritive tools
* Declaritive tools are better for managing infrastructure
* Imperative tools are better for managing configuration

## Terraform
### What is Terraform?
Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a datacenter infrastructure using a high-level configuration language known as Hashicorp Configuration Language (HCL), or optionally JSON.

## Terraform is declaritive tool but it also has some imperative features.
Terraform is a declaritive language but it also has some imperative features. For example, you can use `count` and `for_each` to create multiple resources. You can also use `for` and `for_each` to iterate over lists, maps, and sets. You can also use `dynamic` blocks to create nested blocks.

Terraform Supports:
    * Conditionals
    * Functions
    * Expressions
    * Variables
    * Modules
    * Providers
    * Complex data types   
        * Maps
        * Lists
        * Sets
        * Objects
        * Tuples

## Infrastructure lifecycle
### What is infrastructure lifecycle?
Infrastructure lifecycle is a process of managing infrastructure from plan, design, implement, operate, and decommission of cloud infrastructure.

### What is day 0, day 1, and day 2 operations?
* Day 0 - Planning and design
* Day 1 - Provisioning and deployment
* Day 2 - Operations and management

## How does IaC enhance infrastructure lifecycle?
### Reliability

* IaC is repeatable and consistent: identical copies of infrastructure can be created in different environments
**Idemptotency** - the ability to run the same code multiple times and get the same result

### Manageability

* Enable mutative operations: infrastructure can be updated and changed
* Revision control: infrastructure can be version controlled with minimal changes 

### Sensibility

* avoid finanical waste: infrastructure can be destroyed when not needed
* avoid human errors: infrastructure can be created and destroyed automatically

## Idempotent vs Non-Idempotent

**Non-idempotent** - the ability to run the same code multiple times and get different results (e.g. when i update my IaC and deploy again after launching 2 virtual machines, it will launch 2 more virtual machines)
**Idempotent** - the ability to run the same code multiple times and get the same result (e.g. when i update my IaC and deploy again after launching 2 virtual machines, it will update the existing 2 virtual machines)

## Provisioning vs Orchestration vs Deployment
### Provisioning

* Provisioning is the process of setting up the infrastructure
* You can provision a server using configuration managmeent tools like Ansible, Chef, Puppet, SaltStack, bash scripts, powershell scripts, cloud-init, etc. 
* When you launch a cloud service and configure, you are provisioning the service.

### Orchestration
* Orchestration is the process of managing multiple systems and services as a single unit. You can use orchestration tools like Kubernetes, Docker Swarm, Nomad, etc.
* Orchestration tools are commonly used when working with microservices, containers, and serverless, k8s, etc.

### Deployment
* Deployment is the act of delivering a version of an application to run provisioned infrastructure.
* Deployment cloud be performeve via CI/CD tools like Jenkins, GitLab, CircleCI, etc.

## Confiuration drift
### What is configuration drift?
* Configuration drift is a state of inconsistency between the actual configuration of a system and the expected configuration.
* Configuration drift can occur when manual changes are made to a system, when one system is manually configured differently from another system, or when there are unintended changes to systems due to human error, hardware failure, software failure, or malware.
* Configuration drift can be avoided by using IaC tools like Terraform, Ansible, etc.
**Configuration drift going unnoticed could be a loss or breach of services and residing data or result in intterrpution of services leading to unexpected downtime.**

## Detecting Configuration Drift
* Compliance tools that can detect configuration drift

### How to fix configuration drift?
* Compliance tools that can remediate misconfiguration and configuration drift
  * Chef Inspec
  * Puppet
  * Ansible
  * Terraform
  * AWS Config
  * Azure Policy
  * GCP Config
  * etc.
* Terraform refresh and plan commands can be used to detect configuration drift
* Manually correcting the configuration (not recommended)
* Tear down and rebuild the infrastructure

### How to prevent configuration drift?
* Immutable infrastructure, always create and destroy, never update, Blue/Green deployment strategy
    * Servers are never modified after they're deployed
    * Instead of updating existing servers, you deploy new servers with the updates using AMI, GCP Templates, etc. 
        * AMI - Amazon Machine Image
        * GCP Templates - Google Cloud Platform Templates
    * This approach is more reliable and secure
    * This approach is more scalable
* Using GitOps to version control IaC, and peer review every single pull request change before applying them

## Mutable vs Immutable Infrastructure
### Mutable Infrastructure
* Mutable infrastructure is a traditional approach to managing infrastructure
* Mutable infrastructure is updated by modifying the existing infrastructure
* Develop --> Deploy --> Configure
    * Example: A virtual machine is deployed then a configuration management tool like Ansible, Chef, Salt, Cloud-Init, etc. is used to configure the virtual machine
* No guarentee that the infrastructure will be in the same state as it was before the update
### Immutable Infrastructure
* Immutable infrastructure is a modern approach to managing infrastructure
* Immutable infrastructure is updated by replacing the existing infrastructure
* Develop --> Deploy --> Destroy --> Deploy
    * Example: A virtual machine is deployed then a configuration management tool like Terraform, CloudFormation, etc. When an update is required, the existing virtual machine is destroyed and a new virtual machine is deployed with the updated configuration.
    * Use tools like packer to create immutable images
* Immutable infrastructure is more reliable and secure

## What is GitOps?
* GitOps is a way to do Continuous Delivery, it works by using Git as a single source of truth for declarative infrastructure and applications.
* With Git at the center of your delivery pipelines, developers can make pull requests to accelerate and simplify application deployments and operations tasks to Kubernetes.
* GitOps is a way to do Infrastructure as Code (IaC) and Continuous Delivery (CD).

## GitOps Workflow
* Developers make changes to the Git repository
* A CI/CD pipeline detects the changes and deploys the changes to the infrastructure
* The infrastructure is updated and the changes are reflected in the production environment
    * Example: A developer makes changes to the Git repository, a CI/CD pipeline detects the changes and deploys the changes to the infrastructure, the infrastructure is updated and the changes are reflected in the production environment
* Example tools: ArgoCD, FluxCD, Jenkins X, etc.

## Immutable Infrastructe Guarantees
Terraform encourage you towards an immutable infrastructure approach by making it difficult to modify infrastructure after it has been created. 
* Terraform does not allow you to modify infrastructure after it has been created

Cloud Resource Failure - What if a cloud resource fails?
Application Failure - What if an application fails?
Time to Deploy - What if you need to deploy a new version of your application?

Worst Case Scenarios
    * Accidental Deletions
    * Compromised by malicious actors
    * Natural Disasters - Need to change regions (region outages)

Configuring after deployment does not guarentee 1:1 parity between environments
Every time cloud-init runs post deploy there is no guarentee that the configuration will be the same as it was before
    * Cloud-init is a tool that is used to configure virtual machines after they are deployed
    * Cloud-init is used to configure virtual machines in AWS, GCP, Azure, etc.

What if everything fails?
    * Terraform state file is stored in a remote backend
    * Terraform state file is version controlled
    * Terraform state file is backed up
    * Terraform state file is encrypted
    * Terraform state file is locked

## Hashicorp
* Hashicorp is a company that creates open source tools for cloud infrastructure automation
* Hashicorp tools are used by millions of users and companies
* Hashicorp tools are used by 75% of the Fortune 100
* Hashicorp tools are used by 50% of the Forbes Cloud 100

What is Hashicorp Cloud Platform (HCP)?
HCP is a unified cloud platform that offers managed services for Hashicorp tools
HCP services are cloud agnostic 
**Agnostic** - not limited to a particular domain or system; not bound by a particular set of ideas, principles, or systems.
    * Support for the major cloud service providers (AWS, GCP, Azure)
    * Highly suitable for multi-cloud and hybrid cloud environments
    * Can be leveraged in traditional on-premises data centers such as VMware vSphere

Tools under HCP include:
    * Consul
    * Nomad
    * Vault
    * Terraform
    * Waypoint

### Terraform
* Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently

### Terraform Cloud
* Terraform Cloud is a hosted service for Terraform that provides remote state management, API-driven runs, policy management, and more

### Terraform Enterprise
* Terraform Enterprise is a self-hosted distribution of Terraform Cloud that can be run in an air-gapped environment or in your own cloud account

### Boundary
* Boundary is a secure remote access solution for dynamic infrastructure

### Consul
* Consul is a service networking solution to connect and secure services across any runtime platform and public or private cloud

### Nomad
* Nomad is a highly available, distributed, datacenter-aware cluster and application scheduler designed to support the modern datacenter with support for long-running services, batch jobs, and much more

### Packer
* Packer is a tool for creating machine and container images for multiple platforms from a single source configuration

### Vault
* Vault is a tool for secrets management, encryption as a service, and privileged access management

### Vagrant
* Vagrant is a tool for building and distributing development environments

### Waypoint
* Waypoint is a tool that enables developers to build, deploy, and release any application on any platform with a single workflow

## Terraform
### What is Terraform?
* Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a datacenter infrastructure using a high-level configuration language known as Hashicorp Configuration Language (HCL), or optionally JSON.
* Terraform is a declaritive language

***Notable Features***
* Installable modules
* Remote state management
* Resource Graph
* Change Automation - Plan and predict changes before applying them
* Terraform Registry - A public registry of Terraform modules with over 1000 providers

## What is Terraform Cloud?
* Terraform Cloud is a hosted service for Terraform that provides remote state management, API-driven runs, policy management, and more
* Terraform Cloud is a SaaS (Software as a Service) platform
* Terraform Cloud is a paid service
 
Terraform Cloud Offers:
    * Remote state management
    * Version control integration
    * Flexible workflows
    * Collaboration on infrastructure changes in a single unified web portal.

* Majority of cases you should be using Terraform Cloud
* Cases where you may not want to use it to manage your state file is your company has many regulatory requirements along with a long procurement process. In this case you may want to use Terraform Enterprise, Standard remote backend, Atlantis, etc.

