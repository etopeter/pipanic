pipanic.sh
Description
-----------
piPanic is a bash script for Raspberry Pi intended to work with LED status indicator light. Script checks if user is logged in. If user is logged LED will start blinking if user loggs out LED will stop blinking.

Requirements
------------
wiringPi library (https://projects.drogon.net/raspberry-pi/wiringpi/download-and-install/)

Raspberry Pi GPIO PIN setup
2,2K resistor and light emiting LED

	      +-------------|"<|---------------+
	      |                                |
	2  4  6  8  10 12 14 16 18 20 22 24 26 |
	o  o  o  o  o  o  o  o  o  o  o  o  o  |
	o  o  o  o  o  o  o  o  o  o  o  o  o  |
	1  3  5  7  9  11 13 15 17 19 21 23 25 |
	         |                             |
	         +------~;/\/\220K/\/\;~-------+

Installation
------------
Copy pipanic.sh to /root/scripts/ (or edit service file to change location)

Script is provided with Arch Linux systemd service file copy it to /etc/systemd/system and init with 
* systemctl --reload daemons    - to reload systemctl
* systemctl enable pipanic      - to run script at system startup
* systemctl start pipanic       - to run script



Version 1.0 - Initial version.

Copyright (c) 2013

_Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:_

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
