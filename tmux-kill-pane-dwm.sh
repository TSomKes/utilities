#!/usr/bin/env bash

# kill the current pane, then reset layout to main-left

tmux kill-pane
tmux select-layout main-vertical
