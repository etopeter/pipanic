pipanic.sh
Description
-----------
PiPanic is a bash script for Raspberry Pi to work with LED status indicator light. Script checks if user is logged in. If user is logged LED will start blinking if user loggs out LED will stop blinking.

Requirements
------------
wiringPi library (https://projects.drogon.net/raspberry-pi/wiringpi/download-and-install/)

Copy pipanic.sh to /root/scripts/

Script is provided with Arch Linux systemd service file copy it to /etc/systemd/system and init with 
systemctl --reload daemons    - to reload systemctl
systemctl enable pipanic      - to run script at system startup
systemctl start pipanic       - to run script


Version 1.0 - Initial version.

Copyright (c) 2012

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
