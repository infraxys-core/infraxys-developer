# Installation on Microsoft Windows

## Instructions

Download or clone https://github.com/infraxys-core/infraxys-developer to your local machine:
```bash
git clone https://github.com/infraxys-core/infraxys-developer.git
``` 

### Prerequisites

At least Docker 19.03.1 and Docker Compose 1.24.1 are required to use Infraxys Developer. 
See [Install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/) 

### Installation

Start the installation by running install.bat from the Windows directory of this repository.

Leveraged privileges are required for the installation.  

You will be asked for the Infraxys root-directory (use c:\infraxys, for example) and for a port (8444, for example) where the application will be listening.  
When asked, confirm that it's ok that the specified directory will be shared by Docker.    
The Infraxys-url will be displayed after the installation. It should take no more then 3 minutes for the Infraxys containers to start. 
