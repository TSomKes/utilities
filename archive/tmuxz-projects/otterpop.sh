project="otterpop"
projectDir=~/code/otterpop
winCode="code"

tmux new-session -s "$project" -n "$winCode" -c "$projectDir/src" -d

# 3 panes, main (left) just over 80 columns
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d
tmux select-layout -t "$project":"$winCode" "4d18,159x46,0,0{89x46,0,0,0,69x46,90,0[69x22,90,0,1,69x23,90,23,2]}"

tmux send-keys -t "$project":"$winCode".0 "vim" Enter

tmux send-keys -t "$project":"$winCode".1 "ls" Enter

tmux send-keys -t "$project":"$winCode".2 "git statz" Enter
