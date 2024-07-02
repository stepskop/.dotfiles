#!/bin/bash
notify_levels=(3 5 10 20)
BAT=$(ls /sys/class/power_supply |grep BAT |head -n 1)
last_notify=100
final_dialog=0
ac_status=0
last_ac_status=0

while true; do
	ac_status=$(cat /sys/class/power_supply/AC0/online)
	if [ $ac_status -eq 1 ]; then
		final_dialog=0
	fi
    bat_lvl=$(cat /sys/class/power_supply/${BAT}/capacity)
    if [ $bat_lvl -gt $last_notify ]; then
            last_notify=$bat_lvl
    fi
    for notify_level in ${notify_levels[@]}; do
        if [ $bat_lvl -le $notify_level ]; then
            if [ $notify_level -lt $last_notify ]; then
                notify-send --icon=battery-low --app-name=Battery "Low Battery" "$bat_lvl% battery remaining."
                last_notify=$bat_lvl
            fi
        fi
    done
    if [ $bat_lvl -le 5 ]; then
	    if [ $final_dialog -eq 0 ]; then
			if [ $ac_status -eq 0 ]; then
		    	final_dialog=1
		    	zenity --warning --text="Battery is at $bat_lvl%, get ready to say goodbye" --icon=battery-low
			fi
	    fi
    fi
sleep 30
done
