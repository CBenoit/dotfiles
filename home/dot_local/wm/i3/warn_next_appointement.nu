#!/usr/bin/env nu
let calcurse_output = (^calcurse --next)
let hours = ($calcurse_output | lines | skip 1 | parse -r " *\[(?P<hours>\d+).*" | get hours | str to-int)
if $hours <= 2 { ^notify-send -u normal --icon=x-office-calendar $calcurse_output } {}
