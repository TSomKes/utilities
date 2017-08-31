#!/bin/bash

# Inspired by various Google searches, but also by the book "tmux: productive
# Mouse-Free Devleopment".

# Hard-code-tastic!
# - Relies on my usual directory structure
# - I also use my own git aliases here

project="tsdc"


# Trigger an up-front blocking request for ssh passphrase
ssh-add ~/.ssh/id_rsa


# Third window:  "webservice", 5 panes, main on left
cd ~/code/tsdc

tmux new-window -t "$sessionName" -n code

# Create one horizontal split, which leaves the right-hand pane active.  Then
# split that pane two more times, leaving four total.
# Note: I tried playing with percentages, but that required using the -d flag
# to keep new panes from getting focus, and then I had to futz with changing
# percentages (25, 33, 50...)
tmux split-window -t "$sessionName" -h
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"

tmux select-layout -t "$sessionName" main-vertical

# Make sure the L pane is wide enough
# HACK - Very specific to my current lappy, 'cause I haven't figured out
# how to size the L pane correctly.
tmux resize-pane -t "$sessionName":1.0 -R 5         

# L pane starts empty

# U-R pane starts with ls
tmux send-keys -t "$sessionName":1.1 'ls' Enter

# M-R pane starts with web service being served
tmux send-keys -t "$sessionName":1.2 'make serve-local' Enter

# L-R pane starts with `git statz`
tmux send-keys -t "$sessionName":1.3 'git fetch' Enter
tmux send-keys -t "$sessionName":1.3 'git statz' Enter

# Move focus to L pane (being nice to user)
tmux select-pane -t "$sessionName":1.0

# Fire up some Chrome tabs
google-chrome 'http://localhost:1313' &> /dev/null & # local draft
google-chrome 'http://tsomkes.com' &> /dev/null & # prod
