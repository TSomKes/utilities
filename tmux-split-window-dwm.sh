#!/usr/bin/env bash

# Open a pane after the "last" pane, then reset layout to main-left

paneindices=($(tmux list-panes -F '#{pane_index}'))
lastpane=${paneindices[-1]}
tmux select-pane -t "$lastpane"
tmux split-window
tmux select-layout main-vertical
