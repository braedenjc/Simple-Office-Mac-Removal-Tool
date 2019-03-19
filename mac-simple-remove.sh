#!/bin/bash
#This script is used to simplify the uninstall process for the Mac version of Office365/2016/2019 installs.
#Please note that this script comes with no warranty, and any damage, though unintended, is the fault of the runner.
#Please always double check what you are running!
# --Braeden Jack Christensen, March 2019

#check to see if we are running as root first

if(( "$EUID" != 0 ))
  then
      echo "You must run this script as root or else we can't install!"
      echo "Please run this with 'sudo' and try again."
  exit
fi

#prompt for confirmation. Have user to spell out in capital letters YES for lack-of-coffee protection
echo "This script will remove Office from your Mac. It is going to delete the apps, some hidden files,"
echo "and then have you run another program from Microsoft. There is no method of recovery from here."
read -p "If you are sure, enter 'YES', enter anything else to abort: " confirm

case $confirm in
    YES ) echo "Uninstalling!!";
    echo "Bail out in 5 seconds or else!";
    sleep 5;;
	  
    * ) echo "Quitting...";
	sleep 2 #wait for 2 seconds to give the user time to understand what happened.
	exit;;
esac

#remove the office apps
rm -v '/Applications/Microsoft Word'
rm -v '/Applications/Microsoft Outlook'
rm -v '/Applications/Microsoft Powerpoint'
rm -v '/Applications/Microsoft Excel'

#remove the container folders EXCEPT for outlook
rm -v '~/Group Containers/'
#rename outlook instead to protect user information from being deleted.
#have user download the license removal tool and run it.
#have user reboot
echo "It is -highly- recommended that you reboot after closing the terminal window."
exit
  
