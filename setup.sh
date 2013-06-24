#!/bin/bash
# init
function pause(){
   read -p "$*"
}
current=`pwd`

menu(){
  echo 
	echo "****************************** Apk Multi-Tools *****************************"
	echo "----------------------------------------------------------------------------"
	echo "  1    set permissions/paths - do this 1st"                                                      
	echo "  2    Create Folders - do this 2nd"
	echo "  3    Quit"
	echo "****************************************************************************"
	echo 
	printf "%s" "Please make your decision: "
	read ANSWER

	case "$ANSWER" in
		 1)    perm ;;
		 2)    folder ;;
		 3)    quit ;;
		 *)
			echo "Unknown command: '$ANSWER'";;
	esac
}

perm(){
cd other
chmod 755 7za
chmod 755 aapt
chmod 755 apktool
chmod 755 apktool.jar
chmod 755 baksmali.jar
chmod 755 optipng
chmod 755 signapk.jar
chmod 755 smali.jar
cd $current
chmod 755 script.sh
echo "Done setting permissions"
cd $current
echo "Please make sure to install SOX, if you are on debian/ubuntu open terminal"
echo " and type in"
echo " sudo su"
echo "apt-get install sox"
echo " this will install sox other wise use your software install program to install sox"
echo "once sox is installed you need to add script to your path"
echo " you can do this by opening a new terminal window and type"
echo " sudo su"
echo "gedit /.bashrc and enter this at the bottom of the file"
echo " PATH=$PATH:$current"
pause 'Press Enter to continue...'
echo "Done setting up basics"
menu
}

folder(){
mkdir "place-apk-here-for-modding" 
mkdir "place-apk-here-for-signing" 
mkdir "place-apk-here-to-batch-optimize"
mkdir "place-jar-here-for-modding"
mkdir "place-ogg-here"
mkdir "working"
echo "Done Creating Folders"
menu
}

quit(){
exit 0
}
menu



