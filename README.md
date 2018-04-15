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
	$ echo "ps -aux" > ps.sh
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

## License

[MIT @ Alexander Molnar](LICENSE)
