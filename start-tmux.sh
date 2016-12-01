#!/bin/bash

# Inspired by various Google searches, but also by the book "tmux: productive
# Mouse-Free Devleopment".

sessionName=${PWD##*/}

tmux has-session -t "$sessionName"

if [ $? != 0 ]
then
	# First window:  "code", current directory, 3 panes, main on left
	tmux new-session -s "$sessionName" -n code -d
	tmux split-window -t "$sessionName"
	tmux split-window -t "$sessionName"
	tmux select-layout -t "$sessionName" main-vertical
	tmux send-keys -t "$sessionName":0.1 'ls' C-m
	tmux send-keys -t "$sessionName":0.2 'git statz' C-m

	# Second window:  "notes", ~/code/notes/, 3 panes, main on left
	cd ~/code/notes
	tmux new-window -t "$sessionName" -n notes
	tmux split-window -t "$sessionName"
	tmux split-window -t "$sessionName"
	tmux select-layout -t "$sessionName" main-vertical
	tmux send-keys -t "$sessionName":1.1 'ls' C-m
	tmux send-keys -t "$sessionName":1.2 'git statz' C-m

	# Select main pane of "code" window
	tmux select-window -t "$sessionName":0.1
	tmux select-pane -t "$sessionName":0.1
fi

tmux attach -t "$sessionName"
