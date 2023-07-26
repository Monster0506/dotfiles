xmodmap ~/.xmodmap


setxkbmap -option ctrl:nocaps

# make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'
xset r rate 250 25


xbindkeys 

exec i3
