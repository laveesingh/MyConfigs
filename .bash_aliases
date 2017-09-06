alias codechef="cd ~/Documents/Competitive-Programming/codechef/contests"
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage"
alias testcase="python test.py > test.in; ./a < test.in > test1.out; ./b < test.in > test2.out; diff test1.out test2.out"
alias mm="python manage.py makemigrations"
alias mmm="python manage.py migrate"
alias rs="python manage.py runserver"
alias ms="python manage.py shell"
alias virt="source denv/bin/activate"
alias devirt="deactivate"
alias c++="g++ -std=c++14 -o a"

song(){
  youtube-dl -x --audio-format mp3 "ytsearch: $* full song"
}

