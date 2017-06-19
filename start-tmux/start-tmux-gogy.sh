#!/bin/bash

# Inspired by various Google searches, but also by the book "tmux: productive
# Mouse-Free Devleopment".

# Hard-code-tastic!
# - Relies on my usual directory structure
# - I also use my own git aliases here

project="gogy"


# Trigger an up-front blocking request for ssh passphrase
#ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/gogy_id_rsa

# Third window:  "webservice", 5 panes, main on left
cd ~/code/gogyup-web-services

tmux new-window -t "$sessionName" -n webservice
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux select-layout -t "$sessionName" main-vertical

# Make sure the L pane is wide enough
# HACK - Very specific to my current lappy, 'cause I haven't figured out
# how to size the L pane correctly.
tmux resize-pane -t "$sessionName":1.0 -R 5         

# L pane starts with `ls`
tmux send-keys -t "$sessionName":1.0 'ls' C-m

# U-R pane starts ready to run local tests (w/o carriage return)
tmux send-keys -t "$sessionName":1.1 'make run-tests-local'

# UM-R pane starts with web service being served
tmux send-keys -t "$sessionName":1.2 'make serve-local-clear-datastore' C-m

# LM-R pane starts with DB (in theory)
tmux send-keys -t "$sessionName":1.3 'cd db/' C-m
tmux send-keys -t "$sessionName":1.3 'mysql login-path=client' C-m

# L-R pane starts with `git statz`
tmux send-keys -t "$sessionName":1.4 'git fetch' C-m
tmux send-keys -t "$sessionName":1.4 'git statz' C-m

# Move focus to L pane (being nice to user)
tmux select-pane -t "$sessionName":1.0


# Fourth window:  "client", 4 panes, main on left
cd ~/code/gogyup-literacy-app/
tmux new-window -t "$sessionName" -n client
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux select-layout -t "$sessionName" main-vertical

# Make sure the L panes are wide enough (see HACK)
tmux resize-pane -t "$sessionName":2.0 -R 5         

# L pane starts with `ls`
tmux send-keys -t "$sessionName":2.0 'ls' C-m

# L-R pane starts with `git statz`
tmux send-keys -t "$sessionName":2.3 'git fetch' C-m
tmux send-keys -t "$sessionName":2.3 'git statz' C-m

# M-R pane starts with client site being served
tmux send-keys -t "$sessionName":2.2 'cd litapp-source/www/' C-m
tmux send-keys -t "$sessionName":2.2 'python3 -m http.server 8050' C-m

# Move focus to L pane (being nice to user)
tmux select-pane -t "$sessionName":2.0


# Fire up some Chrome tabs
google-chrome
google-chrome 'https://gogyup-litapp.slack.com/messages/' &> /dev/null
google-chrome 'https://www.toggl.com/app/timer' &> /dev/null
google-chrome 'http://localhost:8000/datastore?type=user' &> /dev/null # Google App Engine
#google-chrome 'http://localhost:8080' &> /dev/null & # Gogy web service home 
google-chrome 'http://localhost:8050' &> /dev/null & # Gogy reader
