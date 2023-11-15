# Terraform
## Infrastructure as code
Some resources to reference:
Terraform Up & Running - Yevgeniy Brikman
https://terraform-best-practices.com 

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

* Terraform Supports:
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
 
* Terraform Cloud Offers:
    * Remote state management
    * Version control integration
    * Flexible workflows
    * Collaboration on infrastructure changes in a single unified web portal.

* Majority of cases you should be using Terraform Cloud
* Cases where you may not want to use it to manage your state file is your company has many regulatory requirements along with a long procurement process. In this case you may want to use Terraform Enterprise, Standard remote backend, Atlantis, etc.

The Underlying Technology of Terraform Cloud and Terraform Enterprise is the same. The difference is that Terraform Cloud is a SaaS (Software as a Service) platform and Terraform Enterprise is a self-hosted platform. This is also known as Terraform Platform.

## Terraform Lifecycle
1. Code
    * Write/Update Terraform configuration files
2. Init
    * Initialize Terraform working directory
3. Plan
    * Generate and show an execution plan
4. Validate
    * Check whether the configuration is valid
5. Apply
    * Builds or changes infrastructure
6. Destroy
    * Destroy Terraform-managed infrastructure

## Change Automation
Change Automation allows you to know exactly what Terraform will change and in what order, avoiding many possible human errors. 
### What is Change Management?
A standard approach to apply change, and resolving issues that may arise from the change.
In the context of Infrastructe as Code (IaC), Change management is the process that will be followed when resources are modified and applied via configuration scripts.
### What is Change Automation?
Change automation is the process of automatically creating a consistent, systemic, and predictable way to apply changes to infrastructur via controls and policies.
* Terraform uses Change Automation to plan and predict changes before applying them, Execution Plans and Resource Graphs are used to apply and review complex changes.
* Terraform uses Change Automation to prevent accidental changes, Terraform state files are used to prevent accidental changes to infrastructure.

#### What is a ChangeSet?
A collection of commits that represent changes made to a version controlled repository. IaC uses ChangeSets so you can see what has changed by who over time.

## Execution Plans
Terraform apply command is used to create an execution plan and apply the changes required to reach the desired state of the configuration.
* Execution Plans are a detailed map of what Terraform will do when you call apply
* Execution Plans are generated based on the current state of your infrastructure and the configuration files in your working directory
* Execution Plans are generated by running the terraform plan command
    * Resources to be added, changed, or destroyed will be displayed in the execution plan
    * A user will be prompted to confirm the execution plan before applying it

## Terraform - Visualizing Execution Plans
* ``Terraform graph`` command is used to generate a visual representation of either a configuration or execution plan
* Allows you to visualize an execution plan
    * Terraform will output a GraphViz file
        * GraphViz is an open source graph visualization software
        * GraphViz file can be converted to an image file
    * dot is a command line tool that is used to convert GraphViz files to image files
``terraform graph | dot -Tsvg > graph.svg``

## Resource Graph
* Terraform builds a dependency graph from your configuration files and walks this graph to generate an execution plan, refresh state, and destroy resources
    * When you use ``terraform graph``, this is a visual presentation of the dependancy graph
* What is a dependancy graph?
    * A dependancy graph is a directed graph that represents a set of dependancies
    * A dependancy graph is a collection of nodes and edges
    * Nodes represent the resources
    * Edges represent the dependancies between the resources
        * Resource Node: Represents a single resource
        * Resource Meta-Node: Represents a set of resources, but does not represent any action on its own
        * Provider Configuration Node: Represents a provider configuration

## Terraform - Use Cases
* Terraform supports a variety of use cases, including:
    * Cloud Infrastructure
    * Networking
    * Security
    * Compliance
    * Observability
    * Data
    * Application Development
    * Delivery Pipelines
    * Edge Computing
    * Multi-Cloud
    * Hybrid Cloud
    * On-Premises
* Multi-Tier Applications
    * Web Servers
    * Application Servers
    * Database Servers
    * Load Balancers
    * Firewalls
    * DNS
    * CDN
    * Storage
    * etc.
* Disposable Environments
    * Development
    * Testing
    * Staging
    * Production
    * etc.
* Resource Schedulers - Terraform is not just defined to cloud infrastructure, it can also be used to schedule resources
    * Nomad
    * Kubernetes
    * Docker Swarm
    * etc.
* Multi-Cloud - Terraform is cloud agnostic, it can be used to manage resources in multiple cloud providers and can be used to even handle cross-cloud dependencies
    * AWS
    * GCP
    * Azure
    * etc.

## Terraform Core and Terraform Plugins
* Terraform Core is responsible for reading configuration files, providing an execution plan of changes, and executing changes
* Terraform Plugins are responsible for understanding API interactions and exposing resources for use in configuration files
* Terraform Core and Terraform Plugins communicate using RPC (Remote Procedure Call)
* Terraform Core and Terraform Plugins are written in Go

## Terraform Provisioners
Provisioners are used to execute scripts on a local or remote machine as part of resource creation or destruction
* Provisioners are used to bootstrap a resource
    * AWS uses user data to bootstrap EC2 instances
    * GCP uses startup scripts to bootstrap Compute Engine instances
    * Azure uses custom script extensions to bootstrap virtual machines

Provisioners are used to perform post-deployment configuration

* Packer is an automated image creation tool that can be used to create immutable images
    * Packer uses provisioners to install software onto the image
    * Packer uses provisioners to configure the image
    * Packer uses provisioners to run tests on the image

* Cloud-init is a provisioner that is used to configure virtual machines in AWS, GCP, Azure, etc.
***Provisioners are not recommended and should be avoided if possible.***
The main reason why provisioners are not recommended is because they are imperative and not declaritive, which can result in a in-consistent state.

Terraform used to directly support third-party provisioners, but this is no longer the case as it has been deprecated. HashiCorp considers Provisioner as poor practice and recommends using other tools like Ansible, Chef, Puppet, SaltStack, etc. to perform configuration management.
Alternatives to Provisioners:
* Ansible
* Chef
* Puppet
* Cloud-init
***Cloud-init supports chef and puppet, so you can just use cloud-init***

```
    #cloud-config
    puppet:
        install: true
        version: "7.7.0"
        install_type: "packages"
        collection: "puppet7"
        cleanup: true
        aio_install_url: "https://raw.githubusercontent.com/puppetlabs/install-puppet/main/install.sh"
        conf_file: "/etc/puppetlabs/puppet/puppet.conf"
        ssl_dir: "/var/lib/puppet/ssl"
        csr_attributes: "/etc/puppetlabs/puppet/csr_attributes.yaml"
        package_name: "puppet"
        exec: false
        exec_args: ['--test']
        conf:
            agent:
                server: "puppetserver.example.org"
```

## Local-exec
* Local-exec is used to run scripts on the machine running Terraform
* Commonly used to trigger configuration management tools like Ansible, Chef, Puppet, SaltStack, etc.

* Command (required)
    * The command that you wish to execute. This can be any command, script, or shell snippet, and is typically formatted as a quoted string.
* working_dir (optional)
    * Where the command should be executed from. If not specified, this defaults to the root module of the configuration.
* interpreter (optional)
    * The interpreter to execute the command. This defaults to the system shell (e.g. /bin/sh on Linux and cmd.exe on Windows) if not specified.
* environment (optional)
    * A map of environment variables to set prior to execution. This is useful for passing secret values to scripts.

```
    resource "aws_instance" "web" {
        # ...
        provisioner "local-exec" {
            command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
        }
    }
```

```
    resource "null_resource" "example2" {
        provisioner "local-exec" {
            command = "Get-Date > completed.txt"
            interpreter = ["PowerShell", "-Command"]
        }
    }
```

```
    resource "aws_instance" "web" {
        # ...
        provisioner "local-exec" {
            command = "echo $KEY_SECRET > credentials.yml"

            environment = {
                KEY = "VALUE"
                SECRET = "VALUE"
            }
        }
    }
```

## Remote-Exec
* Remote-Exec allows you to execute commands on a target resource after a resource is provisioned
* Remote-Exec is useful for provisioning resources with a simple shell script
    * Remote-Exec is not recommended and should be avoided if possible
    * More complex tasks its recommended to use Cloud-Init, and strongly recommended in all cases to bake an image with Packer or EC2 Image Builder

Remote Commands have three different modes:
* inline (default)
    * Inline commands are specified directly in your Terraform configuration
* Script
    * Script commands are specified as a local script path
* Scripts
    * Scripts commands are specified as a remote script path

```
    resource "aws_instance" "web" {
        # ...
        provisioner "remote-exec" {
            inline = [
                "sudo amazon-linux-extras install -y nginx1.12",
                "sudo systemctl start nginx"
            ]
        }
    }
```

```    
    resource "aws_instance "web" {
        # ...
        provisioner "remote-exec" {
            inline = [
                "sudo amazon-linux-extras install -y nginx1.12",
                "sudo systemctl start nginx"
            ]
            scripts = [
                "scripts/remote-exec.sh",
                "scripts/remote-exec2.sh"
            ]
            connection {
                type = "ssh"
                user = "ec2-user"
                private_key = file("~/.ssh/id_rsa")
            }
        }
    }
```

## File Provisioner
* File provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource

* File provisioner is useful for copying files and directories to remote machines
    * File provisioner is not recommended and should be avoided if possible
    * More complex tasks its recommended to use Cloud-Init, and strongly recommended in all cases to bake an image with Packer or EC2 Image Builder

**May need a connection block to specify the connection type, user, and private key**

```
    resource "aws_instance" "web" {
        # ...
        provisioner "file" {
            source = "conf/app.conf"
            destination = "/etc/app.conf"
        }
    }
```

```
    resource "aws_instance" "web" {
        # ...
        provisioner "file" {
            source = "conf/"
            destination = "/etc/"
        }
    }
```

```
    resource "aws_instance" "web" {
        # ...
        provisioner "file" {
            source = "conf/"
            destination = "/etc/"
            connection {
                type = "ssh"
                user = "ec2-user"
                private_key = file("~/.ssh/id_rsa")
            }
        }
    }
```

## Connection 
* A connection block tells a provisioner or resource how to connect to the resource 
* Connection block is used to define the connection type, user, and private key

Can connect via:
* SSH
* SSH Agent
* WinRM

With SSH you can connect through a bastion host, eg:
* bastion_host
* bastion_port
* bastion_user
* bastion_private_key
* bastion_host_key
* bastion_certificate

```
    provisioner "file" {
        source = "conf/app.conf"
        destination = "/etc/app.conf"

        connection {
            type = "ssh"
            user = "root"
            password = "${var.root_password}
            host = "${aws_instance.web.public_ip}"
        }
    }
```

```
    provisioner "file" {
        source = "conf/app.conf"
        destination = "c:/app/app.conf"

        connection {
            type = "winrm"
            user = "Administrator"
            password = "${var.admin_password}"
            host = "${var.host}"
        }
    }
```

## Null Resources
* null_resource is a placeholder resource that have no specific association to a provider resources
* you can provide a connection to trigger to a resource
Triggers is a map of values which should cause this set of provisioners to re-run.
Values are meant to be interpolated references to other resources in the configuration.

```
    resource "aws_instance" "cluster" {
        count = 3
        # ...
    }
```

```
    resource "null_resource" "example" {
        triggers = {
            cluster_instance_ids = "${join(",", aws_instance.cluster.*.id)}"
        }
        provisioner "local-exec" {
            command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
        }
    }
```

## Terraform Data
* Similar to null_resource, data sources are used to define a resource that does not create anything
* Data sources are used to fetch data that is used by other resources

```
    resource "null_resource" "example" {
        triggers = { 
            version = var.version
        }
        provisioner "local-exec" {
            command = "echo ${self.triggers.version}"
        }
    }
```

can be written as:

```
    resource "terraform_data" "example" {
        triggers = { 
            version = var.version
        }
        provisioner "local-exec" {
            command = "echo ${self.triggers.version}"
        }
    }
```

## Terraform Providers
* Terraform providers are responsible for understanding API interactions and exposing resources
* Terraform providers are plugins that Terraform uses to manage resources
* Terraform providers are usually tied to a specific cloud provider

Providers are required for your Terraform Configuration file to work, at least one provider required.

Providers come in three tiers:
* Official
    * Official providers are developed and maintained by HashiCorp
    * Official providers are distributed directly by HashiCorp
    * Official providers are distributed via the Terraform Registry
* Verified
    * Verified providers are developed and maintained by a third-party
    * Verified providers are distributed directly by the third-party
    * Verified providers are distributed via the Terraform Registry
* Community
    * Community providers are developed and maintained by a third-party
    * Community providers are distributed directly by the third-party
    * Community providers are distributed via the Terraform Registry

## Terraform Registry
* Terraform Registry is a public registry of Terraform modules with over 1000 providers
* Providers and Modules are plugins that Terraform uses to manage resources
* Everything published to the Terraform Registry is public-facing

Provider:
A provider is a pugin that is a mapping to a Cloud Service Provider (CSPs) API.

Module:
A module is a group of configuration files that provide a common configuration functionality.
* Enfocres best practices
* Reduce boilerplate code
* Reduce time to develop

### Terraform Registry - Providers
Documentation can be found at https://registry.terraform.io/browse/providers, and can be used to search for providers. This can also be used to find examples of how to use the provider.

### Terraform Cloud - Private Registry
Terraform Cloud offers a private registry that can be used to host private modules and providers. This is useful for organizations that want to keep their modules and providers private.

When creating a module you need to connect it to a version control system (VCS) like GitHub, GitLab, BitBucket, etc. This is where the module will be stored.

### Terraform Providers Command
Get a list of the current providers you are using

```    
    terraform providers
    Providers required by configuration:
    .
    ├── provider[registry.terraform.io/hashicorp/aws]
    └── provider[registry.terraform.io/hashicorp/null]
```

Set an alternative provider

```    
    provider "aws" {
        region = "us-east-1"
        alias = "east"
    }
```

How to reference an alias provider

```    
    resource "aws_instance" "web" {
        provider = aws.east
        # ...
    }
```

How to set alias provider for a parent module

```
    terraform {
        required_providers {
            mycloud = {
                source = "mycorp/mycloud"
                version = "~>1.0.0"
                configuration_aliases = [mycloud.alternate]
            }
        }
    }
```    
   
***~>1.0.0 means any version greater than or equal to 1.0.0***

How to set a alias provider for a child module

```
    module "vpc" {
        source = "./vpc"
        providers = {
            aws = aws.east
        }
    }
```

## Terraform Modules
Terraform module is a group of configuration files that provide common functionality.
* Enforces best practices
* Reduces boilerplate code
* Reduces time to develop

AWS Provider (not a module)
* If you had to create a VPC, Subnet, and Security Group, you would have to create a configuration file for each resource. This would result in a lot of boilerplate code. Instead you can use a module to create all three resources in a single configuration file.

AWS VPC Module
* Using a module you can shorthand Domain Specific Language (DSL) to create a VPC, Subnet, and Security Group in a single configuration file. Reducing the amount of code you have to write.

Amount of work needed to create a VM via the Azure Provider is much more than that of AWS Provider. To reduce you can create an Azure VM via a Compute and Network Module.

## When to use Terraform IaC and Third-Party Configuration Management Tools
A task done one time to setup the database:
Terraform 
    Providers
        Create a Postgres Database
    Modules
        Create a Postgres User
    Provisioner
        Stage seed data
Repeatable tasks for on-going maintenance:
    Ansible
        Backup tables to Datawarehouse
        Truncate daily tables

## Hashicorp Configuration Files
* Terraform files end in extension .tf
* Terraform files are writtin in the Terraform Language

Terraform Language consists of only a few basic elements:
* Blocks - Container for other content, represent an object
    * Block type - can have zero or more labels and a body
    * Block labels - name of block
* Arguments - Key-value pairs inside of a block
    * They appear within blocks
* Expressions - represents a value, either literally or by referencing and combining other values
    * They appear as values for arguments, or within other expressions.

```
    resource "aws_vpc" "main" {
        cidr_block = "var.base_cidr_block"
    }
```

```
    <BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
        # Block body
        <IDENTIFIER> = <EXPRESSION> # Argument
    }
```

HCL is the low-level language that Terraform uses to parse and load configuration files. HCL is also used by other Hashicorp tools like Packer, Consul, Nomad, Vault, etc.
* Hashicorp Configuration Language (HCL) is a configuration language built by Hashicorp

Alternate JSON Syntax
* Terraform also supports an alternate syntax called JSON Syntax
* Terraform expects JSON sytax files to be named with the .tf.json extension

This syntax is useful when generating portions of a configuration programmatically, since it can be easier to generate JSON than HCL.

```
    {
        "resource": {
            "aws_vpc": {
                "main": {
                    "cidr_block": "var.base_cidr_block"
                }
            }
        }
    }
```

## Terraform Settings
The special terraform configuration block type eg. terraform {...} 
* Terraform block is used to configure some behaviors of Terraform itself
    * required_version - Specifies the version of Terraform that is required
    * required_providers - Specifies the providers required by the configuration
    * experimments - Specifies experimental features
    * provider_meta - Specifies provider meta-arguments

```
    terraform {
        required_version = ">= 0.13"
        required_providers {
            aws = {
                source = "hashicorp/aws"
                version = "~> 3.0"
            }
        }
        experiments = [module_variable_optional_attrs]
        provider_meta "aws" {
            module_variable_optional_attrs = true
        }
    }
```
