#!/usr/bin/env sh

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh

function print_error
{
cat << "EOF"
    ./brightnesscontrol.sh <action>
    ...valid actions are...
        i -- <i>ncrease brightness [+5%]
        d -- <d>ecrease brightness [-5%]
EOF
}

function send_notification {
    brightness=`brightnessctl info | grep -oP "(?<=\()\d+(?=%)" | cat`
    brightinfo=$(brightnessctl info | awk -F "'" '/Device/ {print $2}')
    angle="$(((($brightness + 2) / 5) * 5))"
    ico="~/.config/dunst/icons/vol/vol-${angle}.svg"
    bar=$(seq -s "." $(($brightness / 15)) | sed 's/[0-9]//g')
    dunstify "t2" -i $ico -a "$brightness$bar" "Brightness" -r 91190 -t 800
}

function send_kbd_backlight_notification {
    brightness=`brightnessctl -d asus::kbd_backlight info | grep -oP "(?<=\()\d+(?=%)" | cat`
    angle="$(((($brightness + 2) / 5) * 5))"
    ico="~/.config/dunst/icons/vol/vol-${angle}.svg"
    bar=$(seq -s "." $(($brightness / 15)) | sed 's/[0-9]//g')
    dunstify "t2" -i $ico -a "$brightness$bar" "Keyboard Backlight" -r 91190 -t 800
}

function get_brightness {
    brightnessctl -m | grep -o '[0-9]\+%' | head -c-2
}

case $1 in
i)  # increase the backlight
    if [[ $(get_brightness) -lt 10 ]] ; then
        # increase the backlight by 1% if less than 10%
        brightnessctl set +1%
    else
        # increase the backlight by 5% otherwise
        brightnessctl set +5%
    fi
    send_notification ;;
d)  # decrease the backlight
    if [[ $(get_brightness) -le 1 ]] ; then
        # avoid 0% brightness
        brightnessctl set 1%
    elif [[ $(get_brightness) -le 10 ]] ; then
        # decrease the backlight by 1% if less than 10%
        brightnessctl set 1%-
    else
        # decrease the backlight by 5% otherwise
        brightnessctl set 5%-
    fi
    send_notification ;;
ki)
    brightnessctl -d asus::kbd_backlight set +1
    send_kbd_backlight_notification ;;
kd)
    brightnessctl -d asus::kbd_backlight set 1- 
    send_kbd_backlight_notification ;;
*)  # print error
    print_error ;;
esac

