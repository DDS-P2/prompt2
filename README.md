# Apache2 Web Server & Git Server Environment

> This docker container allows scripts pushed from a Git Server to run automatically on an Apache Web Server via https

This environment contains a Git Server and an Apache2 Web Server running with self-signed certificates. The Git Server has a remote repository located at the Web Server with an alias called 'Admin'. When executable scripts, such as python or bash, are pushed, they utilize a post-receive git hook located at the remote repository to transfer to the Web Server's document root located at /var/www/html/. When a user opens a browser to https://localhost, the Web Server redirects from the index.html file to the control.sh script. This control.sh script is able to run on the Web Server because it is is a Common Gateway Interface (CGI) script. Apache2 has been configured to run CGI scripts in the document root instead of just the traditional /usr/lib/cgi-bin/ directory. This control.sh script runs all scripts located in the document root directory and dislays their output on the webpage.

## Table of Contents

- [Security](#security)
- [Install](#install)
- [Usage](#usage)
- [Setup]($setup)
- [License](#license)

## Security

- Default password for all accounts and SSL Key: empiredidnothingwrong

- In order to effectively run Bash and Python scripts automatically from
the Document Root directory, the Apache2 config file had to be set with a
very weak security footprint. For example, the root directory allows for
the execution of any cgi-script or option.

- Though, in this setup, the output of the scripts are shown on the webpage,
it would be trivial to suppress the output and have scripts running in the
background without the user knowing.

## Install

To install this container do BLAH

```
```
## Usage

Example Usage Workflow:
- 'ps aux' → ps.sh → git push → web server runs ps.sh and displays at localhost:443

1. Create Bash Script on Local GitServer:
```
	$ echo "ps -aux" > example.sh
```
2. Make the script executable with the following command:
```
	$ sudo chmod +x example.sh
```
3. Push Script to Remote Repository
```
	$ sudo git add example.sh
	$ sudo git commit -m "My first script"
	$ sudo git push admin
```
4. Open a web browser such as Firefox
5. Type in the following URL: https://localhost:443
6. Watch the output of your script display on the screen!
    
Note: The WebPage will show the output for all Bash and Python scripts currently located in the document root directory!

## Setup

General steps I took to create this environment:
1. Create Local Git Server
```
	$ git init
```
2. Create first testing script file
```
	$ echo "hello, world!" > test.sh
```
3. Enable Apache2 Web Server
```
	$ sudo service apache2 start
```
4. Enable Apache2 SSL module in /etc/apache2/mods-available directory
```
	$ sudo a2enmod ssl.load
```
5. Create ssl/localcerts folder in Apache2 directory to store keys
```
	$ mkdir /etc/apache2/ssl/localcerts
```
6. Create SSL Key for Self-Signed Cert and HTTPS Traffic over 443
```
	$ openssl req -new -x509 -days 365 -nodes -out /etc/apache2/ssl/apache.pem -keyout /etc/apache2/ssl/apache.key
	NOTE: Used 'localhost' for CommonName for testing environment
```
7. Edit Apache2 default-ssl.conf file found in /apache2/sites-available directory
```
	SSLCertificateFile /etc/apache2/ssl/localcerts/apache.pem
	SSLCertificateKeyFile /etc/apache2/ssl/localcerts/apache.key
```
8. Edit Apache2 000.default.conf file found in /apache2/sites-available directory
```
	SSLCertificateFile /etc/apache2/ssl/localcerts/apache.pem
	SSLCertificateKeyFile /etc/apache2/ssl/localcerts/apache.key
```
9. Ensure that /etc/hosts file contains the following line
```
	127.0.0.1	localhost
```
10. Use firefox to browse to https://localhost:443 and ensure self-signed certificate is functional
11. It will ask you to make an exception, click allow
12. Install curl for testing
```
	$ sudo apt-get install curl
```
13. Verify https with curl using the following command
```
	$ curl -k https://localhost:443
	NOTE: the [-k] flag is used to bypass security restraint from self-signed certificate
```
14. Next, I began to configure the use of Common Gateway Inteface (CGI) scripts.
15. Enable the cgi module located in the /etc/apache2/mods-available directory
```
	$ sudo a2enmod cgid
	NOTE: The cgid module is a more efficient version of the regular cgi module.
```
16. CGI scripts by default are run out of the /usr/lib/cgi-bin directory
17. To ensure the module is functional, create a test.sh CGI script here
```
	#!/bin/bash
	printf "Content-type: text/html\n\n"
	printf "Hello World!\n"
```
18. Make the scripy executable
```
	$ sudo chmod +x test.sh
```
19. Browse to https://localhost/cgi-bin/test.sh
20. You should see the following output and not the code itself:

	![cgi-test](cgi-test.png)
21. Now we will get CGI scripts to run from the Web Server's DocumentRoot directory
22. Edit the directives for the /var/www/html Directory in apache2.conf file to allow cgi scripts
```
	<Directory /var/www/html/>
		AddHandler cgi-script .cgi .py .sh
		Options Indexes FollowSymLinks Includes ExecCGI
		AllowOverride All
		Require all granted
	</Directory>
```
23. Create a remote git repository at the Apache2 Document Root
```
	$ mkdir /var/www/html/website.git
	$ sudo git init --bare
```
24. Create a post-receive hook located at website.git/hooks/ to check out the latest tree to /var/www/html
```
	$ cat > hooks/post-receive
	#!/bin/sh
	GIT_WORK_TREE=/var/www/html git checkout -f
	$ sudo chmod +x hooks/post-receive
```
25. Go back to the Local GitServer, create an alias for the remote repository, and push the test.sh script
```
	$ git remote add admin ssh://admin1@localhost/var/www/html/website.git
	$ git push admin +master:refs/heads/master
```
26. With the alias created, future pushes can be done as follows:
```
	$ git add [fileName]
	$ git checkout -m "My message here"
	$ git push admin
```
27. Back on the Web Server directory at /var/www/html/ you should now see the test.sh script
28. Next, edit the index.html default filt to redirect to a CGI bash script that will be used to manage the webpage and scripts
```
	<meta http-equiv="refresh" content="0;url=https://localhost/control.sh">
```
29. This line will run the CGI control.sh bash script whenever a user browses to https://localhost
30. Control.sh is a CGI script that includes html and iteratively calls all of the bash and python scripts located in the directory
31. Open a web browser to https://localhosts and you should immediately see the output of your test.sh script
32. Other testing scripts were made such as diskUsage.sh and pythonTest.sh

## License

[MIT @ Alexander Molnar](LICENSE)
