project="tsn"
projectDir=~/code/tslib.com
winCode="code"
winBackground="background"

tmux new-session -s "$project" -n "$winCode" -c "$projectDir" -d


# Code window:  3 panes, main (left) just over 80 columns
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d
tmux select-layout -t "$project":"$winCode" "4d18,159x46,0,0{89x46,0,0,0,69x46,90,0[69x22,90,0,1,69x23,90,23,2]}"

tmux send-keys -t "$project":"$winCode".0 "vim notes.md" Enter
tmux send-keys -t "$project":"$winCode".1 "ls" Enter
tmux send-keys -t "$project":"$winCode".2 "git statz" Enter


# Background window:  4 panes, tiled
tmux new-window -t "$project" -n "$winBackground" -c "$projectDir" -d

tmux split-window -t "$project":"$winBackground" -c "$projectDir" -d
tmux split-window -t "$project":"$winBackground" -c "$projectDir" -d
tmux split-window -t "$project":"$winBackground" -c "$projectDir" -d

tmux select-layout -t "$project":"$winBackground" tiled

tmux send-keys -t "$project":"$winBackground".0 "make serve" Enter
tmux send-keys -t "$project":"$winBackground".1 "make lynx-browse" Enter

