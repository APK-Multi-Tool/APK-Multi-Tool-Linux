#! /bin/sh
# Apk Manager 4.0 (C) 2010 by Daneshm90
# Ported to Linux by farmatito 2010
# Changelog for linux version:
# v 0.1 Initial version
# v 0.2 added "other" dir to PATH
# v 0.3 removed "function" bashism
# v 0.4 removed more bashisms
# v 0.5 added ogg batch optimization and quoted some vars

ap () {
	echo "Where do you want adb to pull the apk from? " 
	echo "Example of input : /system/app/launcher.apk"
	read INPUT
	APK_FILE=`basename $INPUT`
	adb pull "$INPUT" "place-apk-here-for-modding/$APK_FILE"
	if [ "$?" -ne "0" ] ; then
		echo "Error: while pulling $APK_FILE"
	fi
}

ex () {
	cd other
	rm -f "../place-apk-here-for-modding/repackaged.apk"
	rm -f "../place-apk-here-for-modding/repackaged-signed.apk"
	rm -f "../place-apk-here-for-modding/repackaged-unsigned.apk"
	rm -rf "../out"
	if [ ! -d "../out" ] ; then
		mkdir "../out"
	fi
	clear
	# Must be -o"../out" and not -o "../out"
	7za x -o"../out" ../place-apk-here-for-modding/*.apk
	cd ..
}

opt () {
	cd other
	find "../out/res" -name *.png | while read PNG_FILE ;
	do
		if [ `echo "$PNG_FILE" | grep -c "\.9\.png$"` -eq 0 ] ; then
			optipng -o99 "$PNG_FILE"
		fi
	done
	cd ..
}

sys () {
	cd other
	7za a -tzip "../place-apk-here-for-modding/repackaged-unsigned.apk" ../out/* -mx9
	cd ..
}

oa () {
	rm -rf "out/META-INF"
	sys
}

zip () {
	clear
	echo "1    System  apk "
	echo "2    Regular apk "
	printf "%s" "Please make your decision: "
	read RETVAL
	if [ "x$RETVAL" = "x1" ] ; then
		sys
	elif [ "x$RETVAL" = "x2" ] ; then
		oa
	fi
}

si () {
	cd other
	INFILE="../place-apk-here-for-modding/repackaged-unsigned.apk"
	OUTFILE="../place-apk-here-for-modding/repackaged-signed.apk"
	if [ -e "$INFILE" ] ; then
		java -jar signapk.jar -w testkey.x509.pem testkey.pk8 "$INFILE" "$OUTFILE"
		if [ "x$?" = "x0" ] ; then
			rm "$INFILE"
			echo
		fi
	else
		echo "Warning: cannot find file '$INFILE'"
	fi
	cd ..
}

zipa () {
	for STRING in "signed" "unsigned"
	do
		if [ -e "place-apk-here-for-modding/repackaged-$STRING.apk" ] ; then
			zipalign -fv 4 "place-apk-here-for-modding/repackaged-$STRING.apk" "place-apk-here-for-modding/repackaged-$STRING-aligned.apk"
			if [ "x$?" = "x0" ] ; then
				mv -f "place-apk-here-for-modding/repackaged-$STRING-aligned.apk" "place-apk-here-for-modding/repackaged-$STRING.apk"
			fi
		else
			echo "zipalign: cannot find file 'place-apk-here-for-modding/repackaged-$STRING.apk'"
		fi
	done
}

ins () {
	sudo adb devices
	printf "%s" "Hit Enter to continue "
	read DUMMY
	adb install -r "place-apk-here-for-modding/repackaged-signed.apk"
}

alli () {
	clear
	echo "1    System  apk "
	echo "2    Regular apk "
	printf "%s" "Please make your decision: "
	read RETVAL
	if [ "x$RETVAL" = "x1" ] ; then
		sys
		si
		ins
	elif [ "x$RETVAL" = "x2" ] ; then
		oa
		si
		ins
	fi
}

apu () {
	echo "Where do you want adb to push to and as what name: "
	echo "Example of input : /system/app/launcher.apk "
	read INPUT
	sudo adb devices
	printf "%s" "Hit Enter to continue "
	read DUMMY
	adb remount
	adb push "place-apk-here-for-modding/repackaged-unsigned.apk" "$INPUT"
}

de () {
	cd other
	rm -f "../place-apk-here-for-modding/repackaged.apk"
	rm -f "../place-apk-here-for-modding/repackaged-signed.apk"
	rm -f "../place-apk-here-for-modding/repackaged-unsigned.apk"
	rm -rf "../out"
	rm -rf "out.out"
	clear
	java -jar apktool.jar d ../place-apk-here-for-modding/*.apk "../out"
	cd ..
}

co () {
	cd other
	java -jar apktool.jar b "../out" "../place-apk-here-for-modding/repackaged-unsigned.apk"
	cd ..
}

all () {
	co
	si
	ins
}

bopt () {
	cd other
	mkdir -p "../place-apk-here-to-batch-optimize/original"
	find "../place-apk-here-to-batch-optimize" -name *.apk | while read APK_FILE ;
	do
		echo "Optimizing $APK_FILE"
		# Extract
		7za x -o"../place-apk-here-to-batch-optimize/original" "../place-apk-here-to-batch-optimize/$APK_FILE"
		# PNG
		find "../place-apk-here-to-batch-optimize/original" -name *.png | while read PNG_FILE ;
		do
			if [ `echo "$PNG_FILE" | grep -c "\.9\.png$"` -eq 0 ] ; then
				optipng -o99 "$PNG_FILE"
			fi
		done
		# TODO optimize .ogg files
		# Re-compress
		7za a -tzip "../place-apk-here-to-batch-optimize/temp.zip" ../place-apk-here-to-batch-optimize/original/* -mx9
		FILE=`basename "$APK_FILE"`
		DIR=`dirname "$APK_FILE"`
		mv -f "../place-apk-here-to-batch-optimize/temp.zip" "$DIR/optimized-$FILE"
		rm -rf ../place-apk-here-to-batch-optimize/original/*
	done
	rm -rf "../place-apk-here-to-batch-optimize/original"
	cd ..
}

asi () {
	cd other
	rm -f "../place-apk-here-for-signing/signed.apk"
	java -jar signapk.jar -w testkey.x509.pem testkey.pk8 ../place-apk-here-for-signing/*.apk "../place-apk-here-for-signing/signed.apk"
	#clear
	cd ..
}

ogg () {
	cd other
	find "../place-ogg-here/" -name *.ogg | while read OGG_FILE ;
	do
		FILE=`basename "$OGG_FILE"`
		DIR=`dirname "$OGG_FILE"`
		printf "%s" "Optimizing: $FILE"
		sox "$OGG_FILE" -C 0 "$DIR/optimized-$FILE"
		if [ "x$?" = "x0" ] ; then
			printf "\n"
		else
			printf "...%s\n" "Failed"
		fi
	done
}

quit () {
	exit 0
}

restart () {
	echo 
	echo "****************************** Apk Manager *******************************"
	echo "------------------Simple Tasks Such As Image Editing----------------------"
	echo "  0    Adb pull"
	echo "  1    Extract apk"
	echo "  2    Optimize images inside (Only if \"Extract Apk\" was selected)"
	echo "  3    Zip apk"
	echo "  4    Sign apk (Dont do this if its a system apk)"
	echo "  5    Zipalign apk (Do once apk is created/signed)"
	echo "  6    Install apk (Dont do this if system apk, do adb push)"
	echo "  7    Zip / Sign / Install apk (All in one step)"
	echo "  8    Adb push (Only for system apk)"
	echo "-----------------Advanced Tasks Such As Code Editing-----------------------"
	echo "  9    Decompile apk"
	echo "  10   Compile apk"
	echo "  11   Sign apk"
	echo "  12   Install apk"
	echo "  13   Compile apk / Sign apk / Install apk (All in one step)"
	echo "---------------------------------------------------------------------------"
	echo "  14   Batch Optimize Apk (inside place-apk-here-to-batch-optimize only)"
	echo "  15   Sign an apk        (inside place-apk-here-for-signing folder only)"
	echo "  16   Batch optimize ogg files (inside place-ogg-here only)"
	echo "  17   Quit"
	echo "****************************************************************************"
	echo 
	printf "%s" "Please make your decision: "
	read ANSWER

	case "$ANSWER" in
		 0)   ap ;;
		 1)   ex ;;
		 2)  opt ;;
		 3)  zip ;;
		 4)   si ;;
		 5) zipa ;;
		 6)  ins ;;
		 7) alli ;;
		 8)  apu ;;
		 9)   de ;;
		10)   co ;;
		11)   si ;;
		12)  ins ;;
		13)  all ;;
		14) bopt ;;
		15)  asi ;;
		16)  ogg ;;
		17) quit ;;
		 *)
			echo "Unknown command: '$ANSWER'"
		;;
	esac
}

# Start
PATH="$PATH:$PWD/other"
export PATH
#echo $PATH
# Test for needed programs and warn if missing
ERROR="0"
for PROGRAM in "optipng" "7za" "java" "sudo" "adb" "aapt" "sox"
do
	which "$PROGRAM" > /dev/null 
	if [ "x$?" = "x1" ] ; then
		ERROR="1"
		echo "The program $PROGRAM is missing or is not in your PATH,"
		echo "please install it or fix your PATH variable"
	fi
done
if [ "x$ERROR" = "x1" ] ; then
	exit 1
fi

clear
printf "%s" "Do you want to clean out all your current projects (y/N)? "
read INPUT
if [ "x$INPUT" = "xy" ] || [ "x$INPUT" = "xY" ] ; then
	rm -rf place-apk-here-for-modding
	rm -rf place-apk-here-for-signing
	rm -rf place-apk-here-to-batch-optimize
	rm -rf out
	rm -rf $HOME/apktool
	mkdir place-apk-here-for-modding
	mkdir place-apk-here-for-signing
	mkdir place-apk-here-to-batch-optimize
fi
while [ "1" = "1" ] ;
do
	restart
done
exit 0