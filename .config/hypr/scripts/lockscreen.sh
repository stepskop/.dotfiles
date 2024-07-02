#!/bin/bash

IS_UNLOCKED=$(ps -e | grep hyprlock)

if [ -z "$IS_UNLOCKED" ] 
then 
  hyprlock 
fi
