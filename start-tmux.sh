#!/bin/bash

# Inspired by various Google searches, but also by the book "tmux: productive
# Mouse-Free Devleopment".

# Hard-code-tastic!
# - Relies on my usual directory structure
# - I also use my own git aliases here

originalDir=$PWD

# Were we given a project name?
if [ -z $1 ]
then 
    project="generic"
    sessionName=${PWD##*/}  # Name session for current dir
else
    project=$1
    sessionName=$project
fi

codeScript="~/code/utilities/start-tmux-projects/$project.sh"

# Create session if it doesn't already exist
tmux has-session -t "$sessionName"
if [ $? != 0 ]
then
    
    # First window:  "notes", ~/notes, 2 panes, main on left
    cd ~/notes

    tmux new-session -s "$sessionName" -n notes -d
    tmux split-window -t "$sessionName"
    tmux select-layout -t "$sessionName" main-vertical

    # Make sure the L pane is wide enough
    # HACK - Very specific to my current lappy, 'cause I haven't figured out
    # how to size the L pane correctly.
    tmux resize-pane -t "$sessionName":0.0 -R 5         

    # R pane starts with Dropbox status & `ls`
    tmux send-keys -t "$sessionName":0.1 'dropbox status' Enter

    # Move focus to L pane (being nice to user)
    tmux select-pane -t "$sessionName":0.0


    eval "$codeScript" $sessionName $originalDir


    # Set focus to L pane of first "code" window (being nice to user)
    tmux select-window -t "$sessionName":0.0

fi

tmux attach -t "$sessionName"
