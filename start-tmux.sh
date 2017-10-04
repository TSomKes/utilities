#!/bin/bash

# Inspired by various Google searches, but also by the book "tmux: productive
# Mouse-Free Devleopment".


session="tsomkes"

# Create session if it doesn't already exist
tmux has-session -t "$session"
if [ $? != 0 ]
then
    window="notes"
    notesDir="$HOME/notes"
    
    tmux new-session -s "$session" -n "$window" -c "$notesDir" -d
    tmux split-window -t "$session" -c "$notesDir"

    tmux select-layout -t "$session":"$window" main-vertical

    # R pane starts with Dropbox status & `ls`
    tmux send-keys -t "$session":"$window".1 'dropbox status' Enter
    tmux send-keys -t "$session":"$window".1 'ls' Enter

    # Focus on main pane
    tmux select-pane -t "$session":"$window".0
fi

# Were we given a project name?
if ! [ -z $1 ]
then 
    project=$1
    codeScript="~/code/utilities/tmux-projects/$project.sh"
    eval "$codeScript" $session
fi

tmux attach -t "$session"
