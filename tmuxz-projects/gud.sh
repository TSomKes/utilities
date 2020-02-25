project="gud"
projectDir=~/code/gogyup-dyslexia-client
winCode="code"

tmux new-session -s "$project" -n "$winCode" -c "$projectDir" -d

# 4 panes, main (left) just over 80 columns
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d
tmux split-window -t "$project":"$winCode" -c "$projectDir" -d
tmux select-layout -t "$project":"$winCode" "f416,159x46,0,0{89x46,0,0,0,69x46,90,0[69x14,90,0,3,69x14,90,15,2,69x16,90,30,1]}"

tmux send-keys -t "$project":"$winCode".0 "ls" Enter

tmux send-keys -t "$project":"$winCode".1 "make serve" Enter

#tmux send-keys -t "$project":"$winCode".2 "postman" Enter

tmux send-keys -t "$project":"$winCode".3 "git statz" Enter
