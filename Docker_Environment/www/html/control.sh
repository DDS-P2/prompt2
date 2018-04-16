#!/bin/bash

# BASH SCRIPT FOR WEB SERVER THAT RUNS ALL SCRIPTS IN DIRECTORY

# MAINTAINED BY ALEXANDER MOLNAR
# VERSION NUMBER 1.0

echo "Content-type: text/html"
echo ""

#echo "<h1>$(hostname -s)</h1>"


echo '<html>'
	echo '<head>'
		echo '<center><h1>SCRIPT ANALYSIS</h1>'
		echo '<p><b>Running All Bash & Python Scripts In Directory</b></p></center>'
		echo '<hr>'
		echo '<br><br><br>'

BASH_SCRIPTS=*.sh
PYTHON_SCRIPTS=*.py
echo "<h1>$(sudo chmod 111 ugh.py)</h1>" # Make script executable

for script in $BASH_SCRIPTS
do
	if [ "$script" != "control.sh" ] # Do not run self
	then
		echo '<p><b><center>RUNNING NEXT SCRIPT</center></b></p>'
		echo '<hr>'
		echo $script
		echo '<br>'
		./$script
		echo '<br>'
		echo '<p><b><center>SCRIPT IS COMPLETE</center></b></p>'
		echo '<hr>'
		echo '<br>'
	fi
done

for script in $PYTHON_SCRIPTS
do
	echo '<p><b><center>RUNNING NEXT SCRIPT</center></b></p>'
	echo '<hr>'
	echo $script
	echo '<br>'
	./$script
	echo '<br>'
	echo '<p><b><center>SCRIPT IS COMPLETE</center></b></p>'
	echo '<hr>'
	echo '<br>'

done

echo '<br>'
echo '<p><center><b></u>ALL SCRIPTS HAVE COMPLETED</u></center></b</p>'
echo '<hr>'
echo '<br>'
