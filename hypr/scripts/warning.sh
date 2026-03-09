#!/bin/bash

LEVEL=$(grep -oE '[0-9]+' /sys/class/power_supply/BAT0/capacity)

hyprctl dispatch exec "[float;center;size 800 350;nofullscreenrequest] kitty sh -c '
clear
echo \"████████████████████████████████████████████████████████████████████████████████████████\"
echo \"█                                                                                      █\"
echo \"█                                                                                      █\"
echo \"█                                                                                      █\"
echo \"█                        ⚠️  ⚠️  ⚠️   CRITICAL BATTERY   ⚠️  ⚠️  ⚠️                    █\"
echo \"█                                                                                      █\"
echo \"█                                       LEVEL: ${LEVEL}%                                     █\"
echo \"█                                                                                      █\"
echo \"█                            PLUG IN YOUR CHARGER **IMMEDIATELY**                      █\"
echo \"█                                                                                      █\"
echo \"█                                                                                      █\"
echo \"█                                                                                      █\"
echo \"████████████████████████████████████████████████████████████████████████████████████████\"
echo
echo \"Press ENTER to close...\"
read
'"
