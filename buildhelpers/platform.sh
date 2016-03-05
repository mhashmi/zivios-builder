#!/bin/sh

OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`
E_BADARGS=65

GetVersionFromFile()
{
        VERSION=`cat $1 | tr "\n" ' ' | sed s/.*VERSION.*=\ // `
}

if [ "${OS}" = "SunOS" ] ; then
        OS=Solaris
        ARCH=`uname -p`
        OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
elif [ "${OS}" = "AIX" ] ; then
        OSSTR="${OS} `oslevel` (`oslevel -r`)"
elif [ "${OS}" = "Linux" ] ; then
        KERNEL=`uname -r`
        if [ -f /etc/redhat-release ] ; then
                DIST='RedHat'
                PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
                REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
                # If we can't guess the distribution, we'll default to redhat
                DIST=`cat /etc/redhat-release | awk '{print $1}'`
                if [ "$DIST" = "Red" ]; then
                        $DIST="Redhat"
                fi

        elif [ -f /etc/SuSE-release ] ; then
                DIST=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
                REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
        elif [ -f /etc/mandrake-release ] ; then
                DIST='Mandrake'
                PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
                REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
        elif [ -f /etc/debian_version ] ; then
		# Might be ubuntu. Check for lsb. 
		if [ -f /etc/lsb-release ] && grep -q Ubuntu /etc/lsb-release; then
			. /etc/lsb-release
			DIST=${DISTRIB_ID}
			REV=${DISTRIB_RELEASE}
		else
                	DIST="Debian"
	                REV=`cat /etc/debian_version`
		fi

        fi
        if [ -f /etc/UnitedLinux-release ] ; then
                DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
        fi

        OSSTR="${OS} ${DIST} ${REV}(${PSUEDONAME} ${KERNEL} ${MACH})"

fi

if [ ! -n "$1" ]; then
        echo "Usage: `basename $0` arch | release | distro | distroarch"
        exit $E_BADARGS
fi

case "$1" in
        "arch") echo $MACH
        ;;

        "release") echo $REV
        ;;

        "distro") echo $DIST
        ;;

        "distroarch") echo $DIST-$MACH
        ;;

        *)
        echo "Unknown argument"
        exit $E_BADARGS
esac

exit 0;
