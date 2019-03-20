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
    [Yy][Ee][Ss] ) echo "Uninstalling!!";
    echo "Bail out in 5 seconds or else!";
    sleep 5;;
	  
    * ) echo "Quitting...";
	sleep 2 #wait for 2 seconds to give the user time to understand what happened.
	exit;;
esac

#move to user's home directory
echo 'Moving to:/home/'$(logname)
cd /home/$(logname)

#remove the office apps
echo 'Removing Apps'
sleep 1
rm -v '/Applications/Microsoft Word'
rm -v '/Applications/Microsoft Outlook'
rm -v '/Applications/Microsoft Powerpoint'
rm -v '/Applications/Microsoft Excel'
rm -v '/Applications/Microsoft OneNote'
rm -v '/Applications/OneDrive'
#remove the container folders EXCEPT for outlook
echo ' Removing container folders'
sleep 1
rm -v './Containers/com.microsoft.errorreporting'
rm -v './Containers/com.microsoft.Excel'
rm -v './Containers/com.microsoft.netlib.shipassertprocess'
rm -v './Containers/com.microsoft.Powerpoint'
rm -v './Containers/com.microsort.RMS-XPCService'
rm -v './Containers/com.microsoft.Word'
rm -v './Containers/com.microsoft.onenote.mac'
#rename outlook instead to protect user information from being deleted.
echo 'Renaming Outlook folder to retain contacts, emails, and calendar just in case.'
mv './Containers/com.microsoft.Outlook' './Containers/com.microsoft.Outlook.old'

#Clear Group Containers
echo 'Removing Group Containers'
rm -v './Group Containers/UBF8T346G9.ms'
rm -v './Group Containers/UBF8T346G9.Office'
rm -v './Group Containers/UBF8T346G9.OfficeOsfWebHost'
#have user download the license removal tool and run it.
echo 'Download the license removal tool here to complete the uninstall: https://go.microsoft.com/fwlink/?linkid=849815'
#have user reboot
echo "It is recommended you reboot afterwards before reinstalling."
echo "Please open an issue on the Github page for this script if you have improvements or find any bugs."
exit
  
