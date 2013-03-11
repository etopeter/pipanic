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
# GPIO pin number connected to LED
GPIO_PIN_LED=7						

# GPIO pin number connected to button
GPIO_PIN_BUTTON=8 					

# LED checking command
CMD_LEDCHECK="who | cut -d' ' -f1 | sort | uniq | grep pi"

# LED checking command RESULT
CMD_LEDCHECK_RESULT="pi"
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
					# Execute Panic command
					$(eval ps -fp $(pgrep -d, -u pi) | sed -n '2p' | awk '{print $2}' | xargs kill -9)
				fi
			fi	
		else
			BTN_STATUS=0
		fi

		# Check for LED status command
		LED_CMD_EXEC=$(eval $CMD_LEDCHECK)
		if [ "${LED_CMD_EXEC:-1}" = "$CMD_LEDCHECK_RESULT" ] ; then
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
