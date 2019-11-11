# Installation on macOS and Linux

## Instructions

Download or clone https://github.com/infraxys-core/infraxys-developer to your local machine:
```bash
git clone https://github.com/infraxys-core/infraxys-developer.git
``` 

### macOS - mountable directory
You will be asked to specify the Infraxys root-directory. 
This directory needs to be mountable by Docker.
Configure this through the "File Sharing"-page in Docker preferences.  
See [here](https://stackoverflow.com/questions/45122459/docker-mounts-denied-the-paths-are-not-shared-from-os-x-and-are-not-known/45123074) for an example error.
You can re-run install.sh any time, but the specified directory cannot exist or needs to be empty.

### Prerequisites

At least Docker 19.03.1 and Docker Compose 1.23.2 are required to use Infraxys Developer. 
See the [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/) installation instructions. 

### Installation
Start Infraxys Developer installation from the macOS-and-Linux directory:
```bash
sudo ./install.sh;
```

You will be asked for the Infraxys root-directory and for a port where the application will be available. 
The Infraxys-url will be displayed after the installation. It should take no more then 30 seconds for the Infraxys containers to start. 
