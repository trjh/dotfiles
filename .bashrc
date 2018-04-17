#exec zsh 	# alas, command-line-history editing is zsh isn't working very
		# well

##
# The most basic variables
##
debug=0
#debug=1
OS=`uname`
OSREV=`uname -r`
OSROOT=${OSREV%%.*}
export HOSTNAME=`uname -n`
export HOST="`uname -n | sed -e s'/\..*//'`" # change aa.bb.cc to aa
if tty > /dev/null; then echo interactive shell;

    ##
    # bash configuration settings
    ##
    export HISTFILE=$HOME/.bash_history
    export HISTSIZE=1000
    export SAVEHIST=2000
    set -o notify	#setopt -o notify   # notify user of job starts/stops
    set -o noclobber	#setopt -o noclobber# > does not allow overwrite
    #set -o glob	#setopt -o glob	    # use filename substitution

    ulimit -c 20	#limit coredumpsize 20

    #bindkey -me	# emacs key bindings, like tcsh
    #set as 'set editing-mode emacs' in ~/.inputrc, which is already the default

    umask 022		# set default file-protection to user access only

    ##
    # BASIC aliases
    ##
    alias rm='rm -i'
    alias mv='mv -i'
    alias cp='cp -i'
    alias ls='ls -FC'
    alias lpr='lpr -h'
    alias mroe='less'
    alias more='less'
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
    psgrep() { ps $psarg | grep $1 | grep $greparg $$; }
    # or grep $greparg grep

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

    cutls()		{ command ls -1F $* | cut -c1-39 | command column; }
    xless()		{ xterm -T $1 -e less $1 & }
    yppa()		{ ypmatch $1 passwd; ypmatch -k $1 aliases; }
    noblank()	{ perl -nle 'print unless /^\s*$/;' $1; }
    mdig()		{ dig +pfmin +noqu +noH $* |\
		      egrep -v '(res.options|got.answer|QUERY:|^$)'; }
    maillog()	{ xterm -C -name maillog -display $DISPLAY \
			    -title maillog -geometry 110x12+180+4 \
			    -e $HOME/Mail/Scripts/maillog & }
    maken()		{ make -n $1 2>&1 | perl -pe 's/;/;\n/g'; }
    unknow()	{ perl -ni -e 'if (/^'$1'/) { print STDERR "removed: $_" }' \
			     -e 'else { print }' $HOME/.ssh/known_hosts;
		    }

	    #
	    # Andy Kuo's Neat Anonftp command -- much cleaner in zsh
	    #
    aftp()	{
		    [[ -f $HOME/.netrc ]] && mv $HOME/.netrc $HOME/.netrc-safe;
		    echo -n "machine $1 login anonymous " >! $HOME/.netrc;
		    chmod 600 $HOME/.netrc;
		    echo "password mary@indigo.ie" >> $HOME/.netrc;
		    ftp $1;
		    builtin mv $HOME/.netrc-safe $HOME/.netrc;
    }

	    #
	    # My derivitive xterm name setting things
	    #
    telnet()	{ xtname $1; command telnet $*; xtname; }
    rlogin()	{ xtname $1; command rlogin $*; xtname; }
    ssh()		{ xtname $1; command ssh $*; xtname; }

    [[ $debug == 1 ]] && echo `getdate now` complex alias set done

    #
    # Set the terminal -- but not if run by /usr/bin/which
    #
    [[ -f ~/bin/set-term ]] && eval `~/bin/set-term -`

    [[ $debug == 1 ]] && echo `getdate now` interactive set-term done

    #
    # final bits -- source local zshrc and make sure we're in home dir
    #

    [[ -f .bashrc-$HOST ]] && source .bashrc-$HOST

    cd
fi
