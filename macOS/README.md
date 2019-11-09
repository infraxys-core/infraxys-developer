# Installation on macOS

This installation is tested on macOS High Sierra with Docker version 19.03.1 and docker-compose 1.23.2.

Clone this repository to your local machine:
```bash
git clone https://github.com/infraxys-core/infraxys-developer.git

``` 

Copy file env-example.sh to env-local.sh and modify the variables as needed.

docker: Error response from daemon: Mounts denied:

Make sure all directories in env-local.sh can be mounted by Docker. This can be configured in the "File Sharing"-page in Docker preferences.
See [here](https://stackoverflow.com/questions/45122459/docker-mounts-denied-the-paths-are-not-shared-from-os-x-and-are-not-known/45123074) for an example error.
You can re-run up.sh any time.


Start Infraxys Developer:
```bash
./up.sh
```

The first time this script is run, it will setup a fresh Infraxys Developer environment. 
It will ask you to create a user and then press enter so the script can restart Infraxys.

 
