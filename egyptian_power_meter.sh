#!/bin/bash

# Author		:	Hayssam Noweir
# Date  		: 	19th August 2014
# Description	:	This script will return Egyptian electricity status (Safe, Warn and Critical) 



status=""

function usage
{
	echo "Usage : egyptian_power_meter"
	echo "Usage : egyptian_power_meter json"
	#echo "Usage : eg_power json time"
}



function getStatus()
{
	URL="http://loadmeter.egyptera.org/MiniCurrentLoad.aspx"
	raw_status=`curl -s "$URL"|grep -i "FormView1_"`

	case "$raw_status" in
		*"c3.gif"*)
			status="Critical"
			;;
		*"c2.gif"*)
	 		status="Warning"
			;;
		*"c1.gif"*)
	 		status="Safe"
			;;
		*)
			status="Unknown"
			;;
	esac

}

# Call the GetStatus function
getStatus

# Print Results
if [ "$1" == "json" ]; then
	echo "{"Status":"$status"}"
else
	echo "Status : $status"
fi

