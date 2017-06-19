#!/bin/bash

# Inspired by various Google searches, but also by the book "tmux: productive
# Mouse-Free Devleopment".

# Hard-code-tastic!
# - Relies on my usual directory structure
# - I also use my own git aliases here

sessionName=$1
projectPath=$2


# Trigger an up-front blocking request for ssh passphrase
ssh-add ~/.ssh/id_rsa

# Third window:  "code", provided project directory, 4 panes, main on left
cd $projectPath

tmux new-window -t "$sessionName" -n code
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux select-layout -t "$sessionName" main-vertical

# Make sure the L pane is wide enough
# HACK - Very specific to my current lappy, 'cause I haven't figured out
# how to size the L pane correctly.
tmux resize-pane -t "$sessionName":1.0 -R 5         

# U-R pane starts with `ls`
tmux send-keys -t "$sessionName":1.1 'ls' C-m

# L-R pane starts with `git statz`
tmux send-keys -t "$sessionName":1.3 'git statz' C-m

# Move focus to L pane (being nice to user)
tmux select-pane -t "$sessionName":1.0


# Set focus to L pane of first "code" window (being nice to user)
tmux select-window -t "$sessionName":0.0
