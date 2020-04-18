project="c"
projectDir=~/code/c
winCode="code"

tmux new-session -s "$project" -n "$winCode" -c "$projectDir" -d


# Code window:  3 panes, main (left) just over 80 columns
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d

#tmux select-layout -t "$project":"$winCode" "4d18,159x46,0,0{89x46,0,0,0,69x46,90,0[69x22,90,0,1,69x23,90,23,2]}"
tmux select-layout -t "$project":"$winCode" "69b7,159x46,0,0{89x46,0,0,12,69x46,90,0[69x22,90,0,14,69x23,90,23,13]}"

tmux send-keys -t "$project":"$winCode".0 "vim notes.txt" Enter
tmux send-keys -t "$project":"$winCode".1 "ls" Enter
tmux send-keys -t "$project":"$winCode".2 "git statz" Enter
