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


# Window #6:  AppUser Manager

cd ~/code/gogyup-appuser-manager
tmux new-window -t "$sessionName" -n appuser-mgr
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux select-layout -t "$sessionName" main-vertical

# Make sure the L panes are wide enough (see HACK)
tmux resize-pane -t "$sessionName":5.0 -R 5         

# U-R pane starts with `ls`
tmux send-keys -t "$sessionName":5.1 'ls' Enter

# M-R pane starts with client site being served
tmux send-keys -t "$sessionName":5.2 'make serve' Enter

# L-R pane starts with `git statz`
tmux send-keys -t "$sessionName":5.3 'git fetch' Enter
tmux send-keys -t "$sessionName":5.3 'git statz' Enter

# Move focus to L pane (being nice to user)
tmux select-pane -t "$sessionName":5.0


# Window #7:  Organization Manager

cd ~/code/gogyup-org-manager
tmux new-window -t "$sessionName" -n org-mgr
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux split-window -t "$sessionName"
tmux select-layout -t "$sessionName" main-vertical

# Make sure the L panes are wide enough (see HACK)
tmux resize-pane -t "$sessionName":6.0 -R 5         

# U-R pane starts with `ls`
tmux send-keys -t "$sessionName":6.1 'ls' Enter

# M-R pane starts with client site being served
tmux send-keys -t "$sessionName":6.2 'make serve' Enter

# L-R pane starts with `git statz`
tmux send-keys -t "$sessionName":6.3 'git fetch' Enter
tmux send-keys -t "$sessionName":6.3 'git statz' Enter

# Move focus to L pane (being nice to user)
tmux select-pane -t "$sessionName":6.0


# Fire up some Chrome tabs
google-chrome 'http://localhost:8000/datastore?type=user' \
              'http://localhost:8050' &> /dev/null

#              'https://gogyup-litapp.slack.com/messages/' \
#              'https://www.toggl.com/app/timer' \
#              'http://localhost:8080' \  # Local webservice

# Start Postman (Chrome app)
# Notes:  
#   - Followed directions in https://askubuntu.com/a/741685/19202. 
#   - I worry that the app id might change with new versions/installations...?
#google-chrome --app-id=fhbjgbiflinjbdggehcddcbncdddomop
