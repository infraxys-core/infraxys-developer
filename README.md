# Infraxys Developer

Infraxys Developer is the free version of Infraxys for automation engineers and developers.  
Docker and Docker Compose are used to run the containers.  

# Usage

Create modules with packets, roles and environments using GitHub repositories and share them with others.
 
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

> Infraxys Developer uses https on localhost. If this blocks access in Chrome, then you can open url `chrome://flags/#allow-insecure-localhost` and enable `chrome://flags/#allow-insecure-localhost`. 

### Installation type

Select your installation type:
- [macOS or Linux](macOS-and-Linux/README.md)
- [Windows](Windows/README.md)

If you need to restart the installation, then make sure the specified directory is empty.

### Using Infraxys developer

You will need to do the following to have Infraxys fully up-and-running:
- Open the Utils-slider at the right.
- Drag environment "Infraxys system environment" from gitHub.com -> infraxys-modules -> infraxys-core -> master -> environments and drop it on the root-project in the left project-tree (actually any project is OK).
- Click on the environment. You will see the Infraxys-container. This container needs to be shared with every environment.
- Open the "Included containers"-tab of the root-project
- Drag the Infraxys container from the "Infraxys system environment" into the top-left table.

We're all set to start using Infraxys.

Several modules are already enabled in this clean installation. 
If you want to start creating resources in your AWS account, then there's some extra configuration required.

Follow some examples from [Infraxys by example](https://github.com/infraxys-modules/infraxys-by-example) to get started.
This module should already be in your modules-list.

