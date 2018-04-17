#!/usr/local/bin/zsh -f
#
# anything not used when doing remote commands doesn't go here
#
# $Source: /f3/home/huntert/RCS/.zshrc,v $
# $Id: .zshrc,v 1.3 2003/02/05 19:54:55 huntert Exp $
#
#echo `$HOME/bin/getdate now` starting cshrc

##
# The most basic variables
##
debug=0
#debug=1
OS=`uname`
OSREV=`uname -r`
OSROOT=${OSREV%%.*}
PS1="%m(%1~)> ";			# set prompt -- so easy here!
[[ $USERNAME != "huntert" ]] && PS1="%n-%m(%1~)%% ";
[[ $EUID -eq 0 ]] && PS1="%m(%1~)# ";

echo "Running zsh $ZSH_VERSION"	# this is zshrc
				#  -- only running if interactive (I hope)

[[ $debug == 1 ]] && echo `$HOME/bin/getdate now` shell set

## zsh path -- in .zshenv

##
# zsh configuration settings
##
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=2000
[[ ( $ZSH_VERSION > 3.1.6 ) || ( $ZSH_VERSION == 3.1.6 ) ]] \
	&& setopt -o HIST_EXPIRE_DUPS_FIRST
setopt -o notify		# notify user of job starts/stops
setopt -o noclobber		# won't let you overwrite files with >
setopt -o glob			# use filename substitution

limit coredumpsize 20

bindkey -me	# emacs key bindings, like tcsh

umask 022 # set default file-protection to user access only

##
# BASIC aliases
##
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ls='ls -FC'
alias lpr='lpr -h'
alias mroe='more'
if [[ -f /usr/local/bin/zsh ]]; then
    alias zsu="su root -c /usr/local/bin/zsh"
elif [[ -f /bin/zsh ]]; then
    alias zsu="su root -c /bin/zsh"
else
    alias zsu="su"
fi

[[ -f $HOME/bin/vi.wrapper ]] && alias vi='vi.wrapper'

if [[ ( "$OS" == SunOS ) && ( "$OSROOT" == 4 ) ]]; then
	psarg="auxww"; greparg="-vw"
elif [[ ( ${OS} == "FreeBSD" ) || ( ${OS} == "Linux" ) ]]; then
	psarg="auxww"; greparg="-vw"
elif [[ ( ${OS} == "SunOS" ) && ( ${OSROOT} == "5" ) ]]; then
	psarg="-ef"; greparg="-vw"
else
	psarg="-ef"; greparg="-v"
fi
psgrep() { ps $psarg | grep $1 | grep $greparg $$ }	# or grep $greparg grep

[[ ${OS} == HP-UX ]] && alias fmt=adjust

##
# More complex Aliases / Functions
##

alias	    dir='ls -l \!* | more'
alias 	   date='/bin/date +"%a %h %d %r %Y"'

alias 	  locks='rlog -R -L RCS/*,v *,v'
alias 	  xload="xload -rv -geometry 150x150"
alias   xpurple="xsetroot -solid \#1A0010"
alias  nslookup="nslookup -query=any"
#	alias 	  psnup=psnup -w8.5in -h11in	# not in this country!
# also try pstops -w8.5in -h11in '2:0L@.707(1w,0)+1L@.707(1w,.495h)' in.ps

[[ -f $HOME/.words ]] && alias spell='spell +$HOME/.words'

cutls()		{ command ls -1F $* | cut -c1-39 | command column }
#xless()		{ rxvt -T $1 -e less $1 & }
xless()		{ xtname $1; less $*; xtname }
yppa()		{ ypmatch $1 passwd; ypmatch -k $1 aliases }
noblank()	{ perl -nle 'print unless /^\s*$/;' $1 }
mdig()		{ dig +pfmin +noqu +noH $* |\
		  egrep -v '(res.options|got.answer|QUERY:|^$)' }
maillog()	{ xterm -C -name maillog -display $DISPLAY \
			-title maillog -geometry 110x12+180+4 \
			-e $HOME/Mail/Scripts/maillog & }
vncgerry()	{ if ps -auxw | egrep -q '5950.*maeve'; then
			vncviewer -encodings "copyrect hextile" localhost:5950
		  else
			echo "no ssh tunnel through maeve to gerry..."
		  fi
		}
maken()		{ make -n $1 2>&1 | perl -pe 's/;/;\n/g' }
unknow()	{ perl -ni -e 'if (/^\S*'$1'\S* (1024|2048|ssh-rsa)/) { print STDERR "removed: $_" }' \
		         -e 'else { print }' $HOME/.ssh/known_hosts
		}

	#
	# Andy Kuo's Neat Anonftp command -- much cleaner in zsh
	#
aftp()	{
		[[ -f $HOME/.netrc ]] && mv $HOME/.netrc $HOME/.netrc-safe
		echo -n "machine $1 login anonymous " >! $HOME/.netrc
		chmod 600 $HOME/.netrc
		echo "password mary@indigo.ie" >> $HOME/.netrc
		ftp $1
		builtin mv $HOME/.netrc-safe $HOME/.netrc
}

	#
	# My derivitive xterm name setting things
	#
telnet()	{ xtname $1; command telnet $*; xtname }
rlogin()	{ xtname $1; command rlogin $*; xtname }
ssh()		{ xtname $1; command ssh $*; xtname }

[[ $debug == 1 ]] && echo `getdate now` complex alias set done

#
# Set the terminal -- but not if run by /usr/bin/which
#
#[[ -f $HOME/.termcap ]] && export TERMCAP=$HOME/.termcap
#[[ -d $HOME/.terminfo ]] && export TERMINFO=$HOME/.terminfo
eval `~/bin/set-term -`

[[ $debug == 1 ]] && echo `getdate now` interactive set-term done

#
# final bits -- source local zshrc and make sure we're in home dir
#

[[ -f .zshrc-$HOST ]] && source .zshrc-$HOST

cd
