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
# reset button can be pressed and hold for 1 second to activate PANIC_CMD command.
# In this example panic button forces to logout user by finding user tty process
# and killing it

# Settings
# ----------------------------------------------------------

GPIO_PIN_LED=7						# GPIO pin number connected to LED
GPIO_PIN_BUTTON=8 					# GPIO pin number connected to button
LED_CMD="$(eval who | grep pi | awk '{ print $1 }' )" 	# Command to execute to test if LED should be blinkinga
LED_CMD_RESULT="pi" 					# Result of command
PANIC_CMD="ps -fp $(pgrep -d, -u pi) | awk '{ print $2 }' | sed -n '2p' | xargs kill -9"
# ----------------------------------------------------------

TIMER=0
STATUS=0
LED_STATUS=0
BTN_STATUS=0

gpio mode $GPIO_PIN_BUTTON in 
gpio mode $GPIO_PIN_LED out

while true;
do
	if [ "$TIMER" -eq "5" ] ; then		# run command every 5th count so it won't be to often
		TIMER=0
		# Check for button status
		PIN_STATE=`gpio read $GPIO_PIN_BUTTON </dev/null`;
		if [ "${PIN_STATE:-1}" -eq 0 ] ; then
			if [ $BTN_STATUS -eq 0 ] ;  then
				BTN_STATUS=1 
			else
				if [ $BTN_STATUS -eq 1 ] ; then
					BTN_STATUS=2
					gpio write $GPIO_PIN_LED 1
					LED_STATUS=1
					$(eval $PANIC_CMD )
				fi
			fi	
		else
			BTN_STATUS=0
		fi

		# Check for LED status
		LED_CMD_EXEC=$LED_CMD;
		if [ "${LED_CMD_EXEC:-1}" = "$LED_CMD_RESULT" ] ; then
			if [ $STATUS -eq 0 ] ; then
				STATUS=1
			fi	
			#echo "User $USER is logged in"
		else
			STATUS=0
			#echo "User logged out"
		fi
	else
		if [ "$TIMER" -lt "5" ] ; then		# reset counter 
			TIMER=$((TIMER+1))
		else
			TIMER=0	
		fi
	fi
	
	# LED Blinker
	if [ "$STATUS" -eq 1 ] && [ $BTN_STATUS -eq 0 ]; then
		if [ $LED_STATUS -eq 0 ] ; then
			gpio write $GPIO_PIN_LED 1
			LED_STATUS=1
		else
			gpio write $GPIO_PIN_LED 0
			LED_STATUS=0
		fi
	else
		if [ $LED_STATUS -eq 1 ] ; then		# make sure LED is OFF
			gpio write $GPIO_PIN_LED 0
			LED_STATUS=0
		fi
	fi

sleep 0.25	# loop every 1/4 of a second
done
