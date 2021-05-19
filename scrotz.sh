#!/bin/bash

# Select a screen region for a screenshot, and save it to a file of the given
# name.
#
# Basically, papering over some missing parameters I wish scrot accepted...

FILENAME="$(date -Isecond)"

scrot -s "${HOME}/Pictures/screenshots/${FILENAME}.png"
