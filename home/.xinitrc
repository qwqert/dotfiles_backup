#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export LANG=zh_CN.UTF-8
export LOCALE="zh_CN.UTF-8"
export PATH=$HOME/bin:$PATH

# Input method
export XMODIFIERS="@im=fcitx5"
export QT_IM_MODULE=fcitx5

xrdb ~/.Xresources
#xmodmap ~/.Xmodmap

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

case $1 in
i3)
	exec i3
	;;
*)
	exec i3
	;;
esac


