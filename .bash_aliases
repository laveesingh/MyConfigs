alias codechef="cd ~/Documents/Competitive-Programming/codechef/contests"
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage"
alias testcase="python test.py > test.in; ./a < test.in > test1.out; ./b < test.in > test2.out; diff test1.out test2.out"
alias mm="python manage.py makemigrations"
alias mmm="python manage.py migrate"
alias rs="python manage.py runserver"
alias ms="python manage.py shell"
alias c++="g++ -std=c++14 -o a"
alias tmux-restore="~/.tmux/tmux-resurrect/scripts/restore.sh"
alias tmux-save="~/.tmux/tmux-resurrect/scripts/save.sh"
alias ta="tmux attach -t"
alias td="tmux detach"
alias tn="tmux new-session -s"
alias tl="tmux ls"

song(){
  youtube-dl -x --audio-format mp3 "ytsearch: $* full song"
}

