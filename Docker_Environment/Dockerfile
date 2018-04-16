FROM ubuntu:latest
MAINTAINER Alexander Molnar <alexander.molnar73@gmail.com>

#This RUN updates, upgrades and installs all of the necessary packages

RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y apache2 openssh-server openssl git python libapache2-mod-python wget gconf2 gconf-service libgtk2.0-0 libnotify4 libxtst6 libnss3 gvfs-bin xdg-utils 

#This RUN sets up the user admin1, adds them as a sudoer and sets their password

RUN useradd admin1 && \
usermod -aG sudo admin1 && \
echo admin1:empiredidnothingwrong | chpasswd

#This command exposes ports 443 and 22 to be used by the host

EXPOSE 443 
EXPOSE 22

#During the Docker Build, this copies the configuration files from the tarball to the container image 

COPY www /var/www 
COPY apache2 /etc/apache2 
COPY GitServer /home/admin1/GitServer
COPY cgi-bin /usr/lib

#This is a script that will run at the start of a container

CMD service apache2 start && \
 service ssh start && \
 chmod -R 777 /var/www && \
 chmod -R 777 /home/admin1 && \
 cd /home/admin1/GitServer && \
 su admin1

