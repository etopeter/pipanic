#!/bin/bash
#
#
# piPanic.sh: Raspberry Pi GPIO LED status indicator monitoring script
#
# Piotr Strzyzewski
# github: https://github.com/etopeter
#
# Description: Script monitors if definied user is logged in
# if user is logged in status LED light will start blinking
# if user logges out LED will stop blinking

# Settings
# ----------------------------------------------------------

USER=pi		# monitor user
GPIO_PIN=7	# GPIO pin number connected to LED

# ----------------------------------------------------------

TIMER=0
STATUS=0
LED_STATUS=0

gpio mode $GPIO_PIN out

while true;
do
	if [ "$TIMER" -eq "5" ] ;	# run who command every 5th count so it won't be to often
	then
		TIMER=0
		who | grep $USER  > /dev/null
		if [ $? -eq 0 ] ;
		then
			if [ $STATUS -eq 0 ] ; then STATUS=1; fi	#set STATUS to 1
			#echo "User $USER is logged in"
		else
			STATUS=0
			#echo "User logged out"
		fi
	else
		if [ "$TIMER" -lt "5" ];	# reset counter 
		then 
			TIMER=$((TIMER+1))
		else
			TIMER=0	
		fi
	fi
	if [ "$STATUS" -eq "1" ] ;	# start blinking if STATUS is 1
	then
		
		if [ $LED_STATUS -eq 0 ] ; 
		then 
			gpio write $GPIO_PIN 1
			LED_STATUS=1
		else
			gpio write $GPIO_PIN 0
			LED_STATUS=0
		fi
	else
		if [ $LED_STATUS -eq 1 ] ;	# make sure LED is OFF
		then
			gpio write $GPIO_PIN 0
			LED_STATUS=0
		fi
	fi	

sleep 0.25	# loop every 1/4 of a second
done
