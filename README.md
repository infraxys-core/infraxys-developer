# Infraxys Developer

Infraxys Developer is the free version of Infraxys for automation engineers and developers.  
Docker and Docker Compose are used to run the containers.  

# Usage

Create modules with packets and roles using GitHub repositories and share them with others.
 
## Standalone

Infraxys Developer can be used standalone to provision and manage environments in local datacenters or in the cloud. 
Use modules from other developers or share yours through GitHub. 

## With Infraxys Enterprise

This is the same as the standalone version, but environments are managed through protected servers.  
Configure webhooks in your Git-repositories to automatically update application- and provisioning servers for one or more Infraxys Enterprise environments.

Use the branching model of your choice and enforce the four-eyes principle through protected branches.  

```
developer -> github -> Infraxys environment 1, application server 1
                    -> Infraxys environment 2, application server 2
                    -> Infraxys environment 1, provisioning server 1
                    -> Infraxys environment 1, provisioning server 2
                    -> Infraxys environment 2, application server
                    -> Infraxys environment 2, provisioning server
```

Updates can be pulled manually if a connection between GitHub and Infraxys Enterprise is not desired.

## Installation

### Prerequisites

At least Docker 19.03.1 and Docker Compose 1.23.2 are required to use Infraxys Developer. 
See the [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/) installation instructions. 

### Installation type

Select your installation type:
- [macOS or Linux](macOS-and-Linux/README.md)

### Using Infraxys developer

Several modules are already enabled in this clean installation. 
If you want to start creating resources in your AWS account, then there's some extra configuration required.

See the AWS-core module for details.

