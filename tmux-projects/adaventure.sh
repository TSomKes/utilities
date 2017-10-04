#!/bin/bash

# Note:  Uses my own git aliases

# Trigger an up-front blocking request for ssh passphrase
ssh-add ~/.ssh/id_rsa

window="adaventure"

# Third window:  "webservice", 5 panes, main on left
projectDir="$HOME/code/adaventure"

tmux new-window -t "$session" -n "$window" -c "$projectDir"
tmux split-window -t "$session" -h -c "$projectDir"
tmux split-window -t "$session" -c "$projectDir"
tmux split-window -t "$session" -c "$projectDir"

tmux select-layout -t "$session" main-vertical

# U-R pane starts with ls
tmux send-keys -t "$session":"$window".1 'ls' Enter

# M-R pane starts with mongo
tmux send-keys -t "$session":"$window".2 'mongo' Enter

# L-R pane starts with `git statz`
tmux send-keys -t "$session":"$window".3 'git fetch' Enter
tmux send-keys -t "$session":"$window".3 'git statz' Enter

# Focus on main pane
tmux select-pane -t "$session":"$window".0
