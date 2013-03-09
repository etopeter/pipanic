#!/bin/bash
USER=pi
TIMER=0
STATUS=0
LED_STATUS=0
GPIO_PIN=7


gpio mode $GPIO_PIN out

while true;
do
	if [ "$TIMER" -eq "5" ] ;
	then
		TIMER=0
		who | grep $USER  > /dev/null
		if [ $? -eq 0 ] ;
		then
			if [ $STATUS -eq 0 ] ; then STATUS=1; fi
			#echo "User $USER is logged in"
		else
			STATUS=0
			#echo "User logged out"
		fi
	else
		if [ "$TIMER" -lt "5" ];  
		then 
			TIMER=$((TIMER+1))
		else
			TIMER=0	
		fi
	fi
	if [ "$STATUS" -eq "1" ] ;
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
		if [ $LED_STATUS -eq 1 ] ;
		then
			gpio write $GPIO_PIN 0
			LED_STATUS=0
		fi
	fi	

sleep 0.25
done
