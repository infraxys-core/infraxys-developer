# Infraxys Developer

Infraxys Developer is the free version of Infraxys for automation engineers and developers.  
Docker and Docker Compose are used to run the different containers.  

# Usage

Create modules with packets and roles using GitHub repositories and share them with others.
 
## Standalone

Infraxys Developer can be used standalone to provision and manage environments in local datacenters or in the cloud. 
Use modules from other developers or share yours through GitHub. 

## With Infraxys Enterprise

This is actually the same as the standalone version, but environments are managed through protected servers in a datacenter.  
Configure webhooks in your Git-repositories to automatically update application- and provisioning servers for one or more Infraxys Enterprise environments.

Use the branching model of your choice and enforce the four-eyes principle through protected branches.  


Pushing code to can trigger webhooks to synchronize changes with several Infraxys Enterprise environments. This for both application servers (Packets and Roles) and provisioning servers (Modules).

```
developer -> github -> Infraxys environment 1, application servers
                    -> Infraxys environment 1, provisioning server 1
                    -> Infraxys environment 1, provisioning server 2
                    -> Infraxys environment 2, application servers
                    -> Infraxys environment 2, provisioning server 1
```

## Installation

### Prerequisites

Docker and Docker Compose are required to use Infraxys Developer. 
See the [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/) installation instructions. 

### Installation type

Select your installation type:
- [macOS](macOS/README.md)

### Using Infraxys developer

Several modules are already enabled in this clean installation. 
If you want to start creating resources in your AWS account, then there's some extra configuration required.

See the AWS-core module for details.

