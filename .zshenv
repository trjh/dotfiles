#
# zsh env file -- contains environment setup stuff
#
function setenv() { export $1="$2" }

##
# The most basic variables
##
debug=0
#debug=1
#setenv USER thunter
OS=`uname`
OSREV=`uname -r`
OSROOT=${OSREV%%.*}
export HOSTNAME=`uname -n`
export HOST="`uname -n | sed -e s'/\..*//'`" # change aa.bb.cc to aa
#set unixtype = `bin/unixtype`

##
# Basic Paths
##
PATH=$HOME/bin:/bin:/etc:/sbin:/usr/bin:/usr/etc:/usr/sbin:/usr/bin/X11
	# the below aren't everywhere, but just in case...
PATH=$PATH:/usr/local/indigo/bin:/usr/local/sbin:/var/qmail/bin
 
if [[ -x /usr/bin/manpath ]]; then
        # don't set one -- system will do better on it's own
else   
        export MANPATH=/usr/man:/usr/local/man
fi

[[ $debug == 1 ]] && echo `getdate now` basic path set

for bindirectory in $HOME/bin/$OS$OSROOT $HOME/Mail/Scripts $HOME/bin/hosts \
		/usr/local/ssh/bin \
                /usr/5bin /usr/ucb /usr/lib /usr/ccs/bin /usr/games \
                /usr/hosts /usr/local/bin /usr/local/etc /usr/contrib/bin \
                /usr/contrib/bin/X11 /usr/X11R6/bin; 
do
        if [[ -d $bindirectory ]]; then PATH=$PATH:$bindirectory; fi
done    

if [[ ! -x /usr/bin/manpath ]]; then
        if [[ -d /usr/contrib/man ]]; then MANPATH=$MANPATH:/usr/contrib/man; fi
        if [[ -d /usr/X11R6/man   ]]; then MANPATH=$MANPATH:/usr/X11R6/man; fi
	export MANPATH
fi

PATH=$PATH:.

export PATH

[[ $debug == 1 ]] && echo `getdate now` all path set

##
# Program Configuration Variables
##
if [[ ${OS} != "FreeBSD" ]]; then
        # FreeBSD works just fine without LD_LIBRARY_PATH settings...
        setenv LD_LIBRARY_PATH          /usr/lib
        if [[ -d $HOME/bin/$OS$OSROOT/lib ]]; then
                setenv LD_LIBRARY_PATH $HOME/bin/$OS$OSROOT/lib:/usr/lib
	fi
fi

setenv AUTHORCOPY       ~/News/mbox
setenv EDITOR           vi
setenv PAGER            less
setenv BLOCKSIZE        K

setenv NAME "Tim Hunter"
setenv SIGNATURE "Tim Hunter"
setenv EXINIT 'set ts=8 sw=8 wm=5'
setenv SUER huntert
setenv MORE "-e"			# for immediate end on OSF/1 "more"
setenv PKG_TMPDIR /var/pkg_tmp		# for brazil systems...

#
# stuff for cvs
#
setenv CVS_RSH ssh
setenv CVSROOT huntert@cvs00.intsvc.cra.dublin.eircom.net:/force
