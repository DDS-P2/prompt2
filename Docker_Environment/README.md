# README for Docker Environment

- Alexander Molnar's submission for Prompt 2 for the DDS Project Team. 

## USAGE
This project utilizes Docker and was created on a *Nix* machine. The dependencies required to use this project are:
    * docker
    * bash
    * web browser

To run this program, clone this repository, or download the tarball. The directory should include the following files and Directories. 
    * Dockerfile
    * start.sh 
    * README.md 
    * GitServer/
    * apache2/
    * cgi-bin/
    * www/

- From inside the repository, run the start.sh bash script. This script will build the image, then instantiate it. 

- Once instantiated, the user will be given a bash shell inside the container that is hosting both the web server, and the Git Server. 

- To add commit a file, first configure the global username and email using
```
 git config --global user.name admin
 git config --global user.email admin@gmail.com 

 git add <filename>
 git commit -m "message"
 git push admin master
```
To visit the results webpage, browse to https://localhost
