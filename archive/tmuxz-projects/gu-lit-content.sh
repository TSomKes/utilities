#!/bin/bash

port=10006
portAdmin=10007

window="gu-lit-content"

# Prevent creating duplicate windows
tmux select-window -t "$session":"$window"
if [ $? != 0 ]
then
    # Trigger an up-front blocking request for ssh passphrase
    ssh-add ~/.ssh/gogy_id_rsa

    projectDir="$HOME/code/gu-lit-content"

    tmux new-window -t "$sessionName" -n "$window" -c "$projectDir"
    tmux split-window -t "$sessionName" -c "$projectDir"
    tmux split-window -t "$sessionName" -c "$projectDir"
    tmux split-window -t "$sessionName" -c "$projectDir"

    tmux select-layout -t "$sessionName" main-vertical

    # U-R pane starts with ls
    tmux send-keys -t "$sessionName":"$window".1 'ls' Enter

    # M-R pane starts with web service being served
    tmux send-keys -t "$sessionName":"$window".2 'make serve' Enter

    # L-R pane starts with `git statz`
    tmux send-keys -t "$sessionName":"$window".3 'git fetch' Enter
    tmux send-keys -t "$sessionName":"$window".3 'git statz' Enter

    # Focus on main pane
    tmux select-pane -t "$sessionName":"$window".0

    # Fire up some Chrome tabs
    google-chrome "http://localhost:$port" \
              "http://localhost:$portAdmin" &> /dev/null
fi

# Not attached to session?
if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } 
then
    tmux attach -t "$session"
fi
