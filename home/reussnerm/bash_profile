if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi

if [ -d ~/.bin ] ; then
  PATH=~/.bin:"${PATH}"
fi

alias link="lynx -dump -hiddenlinks=merge  -listonly -nonumbers -useragent='Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1' $1"
alias transfert="rsync -vrlPtz -e ssh HOSTNAME:MAILDIR/* ."
alias transfert2="rsync -vrlPtz --remove-source-files -e ssh HOSTNAME:Downloads/* ."
alias xpraHost="xpra attach ssh:HOST:100"
alias ctrlc='xclip -selection c'
alias ctrlv='xclip -selection c -o'
alias remotepast="ctrlv|ssh pastelink 'xclip -loop 10 -display :100 -quiet -selection c'"
