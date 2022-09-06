#-*- tab-width: 4; -*-
# ex:ts=4
#
# commands.mk - Common commands used within the ports infrastructure
#

#

COMMANDS_Include_MAINTAINER=		ctriv@MidnightBSD.org

.if !defined(_COMMANDSMKINCLUDED)

_COMMANDSMKINCLUDED=     yes

AWK?=		/usr/bin/awk
BASENAME?=	/usr/bin/basename
BRANDELF?=	/usr/bin/brandelf
BSDMAKE?=	/usr/bin/make
BZCAT?=		/usr/bin/bzcat
BZIP2_CMD?=	/usr/bin/bzip2
CAT?=		/bin/cat
CHGRP?=		/usr/bin/chgrp
CHMOD?=		/bin/chmod
CHOWN?=		/usr/sbin/chown
CHROOT?=	/usr/sbin/chroot
COMM?=		/usr/bin/comm
CP?=		/bin/cp
CPIO?=		/usr/bin/cpio
CUT?=		/usr/bin/cut
DC?=		/usr/bin/dc
DIALOG?=	/usr/bin/dialog
DIALOG4PORTS?=	${LOCALBASE}/bin/dialog4ports
DIFF?=		/usr/bin/diff
DIRNAME?=	/usr/bin/dirname
DOAS?=		/usr/bin/doas
EGREP?=		/usr/bin/egrep
EXPR?=		/bin/expr
FALSE?=		false				# Shell builtin
FILE?=		/usr/bin/file
FIND?=		/usr/bin/find
FLEX?=		/usr/bin/flex
FMT?=		/usr/bin/fmt
FMT_80?=	${FMT} 75 79
GCPIO?=		${LOCALBASE}/bin/gcpio
GMAKE?=		${LOCALBASE}/bin/gmake
GREP?=		/usr/bin/grep
GUNZIP_CMD?=	/usr/bin/gunzip -f
GZCAT?=		/usr/bin/gzcat
GZIP?=		-9
GZIP_CMD?=	/usr/bin/gzip -nf ${GZIP}
HEAD?=		/usr/bin/head
ID?=		/usr/bin/id
IDENT?=		/usr/bin/ident
JOT?=		/usr/bin/jot
LDCONFIG?=	/sbin/ldconfig
LHA_CMD?=	${LOCALBASE}/bin/lha
LN?=		/bin/ln
LS?=		/bin/ls
MKDIR?=		/bin/mkdir -p
MKTEMP?=	/usr/bin/mktemp
MOUNT?=		/sbin/mount
MOUNT_DEVFS?=	${MOUNT} -t devfs devfs
MOUNT_NULLFS?=	/sbin/mount_nullfs
MV?=		/bin/mv
OBJCOPY?=	/usr/bin/objcopy
OBJDUMP?=	/usr/bin/objdump
PASTE?=		/usr/bin/paste
PAX?=		/bin/pax
PRINTF?=	/usr/bin/printf
PS_CMD?=	/bin/ps
PW?=		/usr/sbin/pw
REALPATH?=	/bin/realpath
RLN?=		${INSTALL} -l rs
RM?=		/bin/rm
RMDIR?=		/bin/rmdir
SED?=		/usr/bin/sed
SETENV?=	/usr/bin/env
SH?=		/bin/sh
SORT?=		/usr/bin/sort
STAT?=		/usr/bin/stat
STRIP_CMD?=	/usr/bin/strip
SU_CMD?=	/usr/bin/su root -c
SYSCTL?=	/sbin/sysctl
TAIL?=		/usr/bin/tail
TEST?=		test				# Shell builtin
TR?=		/usr/bin/tr
TRUE?=		true				# Shell builtin
UMOUNT?=	/sbin/umount
UNAME?=		/usr/bin/uname
UNMAKESELF_CMD?=	${LOCALBASE}/bin/unmakeself
UNZIP_CMD?=	${LOCALBASE}/bin/unzip
UNZIP_NATIVE_CMD?=	/usr/bin/unzip
WHICH?=		/usr/bin/which
XARGS?=		/usr/bin/xargs
XMKMF?=		${LOCALBASE}/bin/xmkmf -a
XZ?=		-Mmax
.if exists(/usr/bin/xz)
XZ_CMD?=	/usr/bin/xz ${XZ}
.else
XZ_CMD?=	${LOCALBASE}/bin/xz ${XZ}
.endif
YACC?=		/usr/bin/yacc

MD5?=		/sbin/md5
RMD160?=	/sbin/rmd160
SHA256?=	/sbin/sha256
SOELIM?=	/usr/bin/soelim

# ECHO is defined in /usr/share/mk/sys.mk, which can either be "echo",
# or "true" if the make flag -s is given.  Use ECHO_CMD where you mean
# the echo command.
ECHO_CMD?=	echo				# Shell builtin

# Used to print all the '===>' style prompts - override this to turn them off.
ECHO_MSG?=	${ECHO_CMD}

.endif
