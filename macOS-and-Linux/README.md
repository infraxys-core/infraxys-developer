# Installation on macOS and Linux

## Instructions

Clone this repository to your local machine:
```bash
git clone https://github.com/infraxys-core/infraxys-developer.git
``` 

### macOS - mountable directory
You will be asked to specify the Infraxys root-directory. 
This directory needs to be mountable by Docker.
Configure this through the "File Sharing"-page in Docker preferences.  
See [here](https://stackoverflow.com/questions/45122459/docker-mounts-denied-the-paths-are-not-shared-from-os-x-and-are-not-known/45123074) for an example error.
You can re-run install.sh any time, but the specified directory cannot exist or needs to be empty.

### Installation
Start Infraxys Developer installation:
```bash
cd macOS-and-Linux;
./install.sh;
```

You will be asked for the Infraxys root-directory and for a port where the application will be available. 
The Infraxys-url will be displayed after the installation. It should take no more then 30 seconds for the Infraxys containers to start. 

