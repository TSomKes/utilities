#!/bin/bash

window="gu-ws"

# Prevent creating duplicate windows
tmux select-window -t "$session":"$window"
if [ $? != 0 ]
then
    # Trigger an up-front blocking request for ssh passphrase
    ssh-add ~/.ssh/gogy_id_rsa

    projectDir="$HOME/code/gogyup-web-services"


    ## First window - web service

    tmux new-window -t "$sessionName" -n "$window" -c "$projectDir"
    tmux split-window -t "$sessionName" -c "$projectDir"
    tmux split-window -t "$sessionName" -c "$projectDir"
    tmux split-window -t "$sessionName" -c "$projectDir"

    tmux select-layout -t "$sessionName" main-vertical

    # U-R pane starts with ls
    tmux send-keys -t "$sessionName":"$window".1 'ls' Enter

    # M-R pane starts with web service being served
    tmux send-keys -t "$sessionName":"$window".2 'make serve-local' Enter

    # L-R pane starts with `git statz`
    tmux send-keys -t "$sessionName":"$window".3 'git fetch' Enter
    tmux send-keys -t "$sessionName":"$window".3 'git statz' Enter

    # Focus on main pane
    tmux select-pane -t "$sessionName":"$window".0


    ## Second window - DB

    windowDB="$window-db"
    projectDirDB="$projectDir/db"

    tmux new-window -t "$sessionName" -n "$windowDB" -c "$projectDirDB"
    tmux split-window -t "$sessionName" -c "$projectDirDB"
    tmux split-window -t "$sessionName" -c "$projectDirDB"

    tmux select-layout -t "$sessionName" main-vertical

    # L pane starts connected to local DB 
    tmux send-keys -t "$sessionName":"$windowDB".0 'mysql --login-path=local --database=gogy --prompt="local> "' Enter

    # U-R pane starts ready to connect to TEST DB
    tmux send-keys -t "$sessionName":"$windowDB".1 'mysql --login-path=test --database=gogy --prompt="TEST> "'

    # L-R pane starts ready to connect to PROD DB
    tmux send-keys -t "$sessionName":"$windowDB".2 'mysql --login-path=prod --database=gogy --prompt="PROD> "'

    # Focus on main pane
    tmux select-pane -t "$sessionName":"$windowDB".0


    # ...and return focus to main pane of first window
    tmux select-window -t "$sessionName":"$window".0
fi

tmux attach -t "$session"
