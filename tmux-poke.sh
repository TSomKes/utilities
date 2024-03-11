#!/usr/bin/env bash
#
# Display a reminder to log a "doing" entry
# So far, not being done via /etc/cron.d/.  Instead, just straight-up crontab.
# $ crontab -e
# */30 * * * * ~/code/utilities/tmux-poke.sh

tmux display-message -d 10000 "#[fill=yellow bg=white align=centre]   ***   Whatcha doin'?   ***   "
