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

# Second window:  "webservice", 4 panes, main on left
cd ~/code/gogyup-web-services

tmux new-window -t "$sessionName" -n webservice

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


# Third window:  DB
cd ~/code/gogyup-web-services/db

tmux new-window -t "$sessionName" -n DB

# Create one horizontal split, which leaves the right-hand pane active.  Then
# split that pane again, leaving three total.
tmux split-window -t "$sessionName" -h
tmux split-window -t "$sessionName"

tmux select-layout -t "$sessionName" main-vertical

# Make sure the L pane is wide enough
# HACK - Very specific to my current lappy, 'cause I haven't figured out
# how to size the L pane correctly.
tmux resize-pane -t "$sessionName":2.0 -R 5         

# L pane starts connected to local DB 
tmux send-keys -t "$sessionName":2.0 'mysql --login-path=local --database=gogy --prompt="local> "' Enter

# U-R pane starts ready to connect to TEST DB
tmux send-keys -t "$sessionName":2.1 'mysql --login-path=test --database=gogy --prompt="TEST> "'

# L-R pane starts ready to connect to PROD DB
tmux send-keys -t "$sessionName":2.2 'mysql --login-path=test --database=gogy --prompt="PROD> "'

# Move focus to L pane (being nice to user)
tmux select-pane -t "$sessionName":2.0


# Fourth window:  "client", 4 panes, main on left
cd ~/code/gogyup-literacy-app/
tmux new-window -t "$sessionName" -n client
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux select-layout -t "$sessionName" main-vertical

# Make sure the L panes are wide enough (see HACK)
tmux resize-pane -t "$sessionName":3.0 -R 5         

# L pane starts with `ls`
tmux send-keys -t "$sessionName":3.0 'ls' Enter

# L-R pane starts with `git statz`
tmux send-keys -t "$sessionName":3.3 'git fetch' Enter
tmux send-keys -t "$sessionName":3.3 'git statz' Enter

# M-R pane starts with client site being served
tmux send-keys -t "$sessionName":3.2 'cd litapp-source/www/' Enter
tmux send-keys -t "$sessionName":3.2 'python3 -m http.server 8050' Enter

# Move focus to L pane (being nice to user)
tmux select-pane -t "$sessionName":3.0


# Fire up some Chrome tabs
google-chrome 'https://gogyup-litapp.slack.com/messages/' &> /dev/null
google-chrome 'https://www.toggl.com/app/timer' &> /dev/null
google-chrome 'http://localhost:8000/datastore?type=user' &> /dev/null # Google App Engine
#google-chrome 'http://localhost:8080' &> /dev/null & # Gogy web service home 
google-chrome 'http://localhost:8050' &> /dev/null & # Gogy reader

# Start Postman (Chrome app)
# Notes:  
#   - Followed directions in https://askubuntu.com/a/741685/19202. 
#   - I worry that the app id might change with new versions/installations...?
google-chrome --app-id=fhbjgbiflinjbdggehcddcbncdddomop
