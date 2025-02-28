PORTNAME=	gdb
PORTVERSION=	8.2
CATEGORIES=	devel
MASTER_SITES=	GNU

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	GNU GDB of newer version than comes with the system

LICENSE=	gpl3
LICENSE_FILE=	${WRKSRC}/COPYING3

# untested on sparc64, might work
ONLY_FOR_ARCHS=	aarch64 amd64 armv6 armv7 i386 mips powerpc powerpc64

LIB_DEPENDS=	libmpfr.so:math/mpfr

# XXX: This should be compiler:c++11-lib as GDB doesn't really require
# C++14.  However, clang in 1.0 crashes while building this port.
# Requiring C++14 forces 1.0 to use an external version of clang
USES=		compiler:c++14-lang cpe gettext-runtime gmake libtool tar:xz
USE_CSTD=	gnu89
CPE_VENDOR=	gnu
GNU_CONFIGURE=	yes
CONFIGURE_ENV=	CONFIGURED_M4=m4 CONFIGURED_BISON=byacc
CONFIGURE_ARGS=	--program-suffix=${PORTVERSION:S/.//g} \
		--enable-targets=all --enable-64-bit-bfd \
		--with-gdb-datadir=${PREFIX}/share/gdb${PORTVERSION:S/.//g} \
		--with-separate-debug-dir=/usr/lib/debug \
		${ICONV_CONFIGURE_ARG} \
		--with-expat=yes --with-libexpat-prefix=${LOCALBASE} \
		--without-libunwind-ia64 --with-system-zlib
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd10.4
CFLAGS:=	${CFLAGS:C/ +$//}	# blanks at EOL creep in sometimes
CFLAGS+=	-DRL_NO_COMPAT -Wno-unused-function -Wno-unused-variable
CFLAGS+=	-Wno-unknown-warning-option
EXCLUDE=	dejagnu expect sim texinfo intl
EXTRACT_AFTER_ARGS=	${EXCLUDE:S/^/--exclude /}
EXTRA_PATCHES=	${FILESDIR}/commit-8aa0243d54
LIB_DEPENDS+=	libexpat.so:textproc/expat2

VER=		${PORTVERSION:S/.//g}
PLIST_SUB=	VER=${VER}

NO_TEST=	yes

OPTIONS_DEFINE=	DEBUG GDB_LINK GUILE KGDB PYTHON TUI

OPTIONS_DEFAULT=	GDB_LINK KGDB PYTHON TUI PORT_READLINE PORT_ICONV SYSTEM_ZLIB

OPTIONS_SINGLE=	READLINE ICONV ZLIB
OPTIONS_SINGLE_READLINE=	BUNDLED_READLINE PORT_READLINE
OPTIONS_SINGLE_ICONV=	PORT_ICONV SYSTEM_ICONV
OPTIONS_SINGLE_ZLIB=	BUNDLED_ZLIB SYSTEM_ZLIB

GDB_LINK_DESC=		Create ${PREFIX}/bin/gdb symlink
KGDB_DESC=		Kernel Debugging Support
BUNDLED_READLINE_DESC=	from gdb distfile
BUNDLED_ZLIB_DESC=	from gdb distfile
PORT_READLINE_DESC=	from devel/readline port
PORT_ICONV_DESC=	use libiconv, with wider charset support
SYSTEM_ICONV_DESC=	use libc iconv, with no wchar support
SYSTEM_ZLIB_DESC=	use system zlib
TUI_DESC=		Text User Interface enabled

OPTIONS_SUB=	yes

BUNDLED_READLINE_CONFIGURE_OFF=	--with-system-readline
DEBUG_CFLAGS=		-g
GUILE_CONFIGURE_WITH=	guile
GUILE_USES=		pkgconfig
GUILE_LIB_DEPENDS=	libguile-2.0.so:lang/guile2
PORT_READLINE_USES=	readline
PORT_ICONV_USES=	iconv:wchar_t
PYTHON_CONFIGURE_ON=	--with-python=${PYTHON_CMD}
PYTHON_CONFIGURE_OFF=	--without-python
PYTHON_USES=		python
SYSTEM_ICONV_USES=	iconv
SYSTEM_ZLIB_WITH=	system-zlib
TUI_CONFIGURE_ENABLE=	tui

.include <bsd.port.pre.mk>

.if ! ${PORT_OPTIONS:MBUNDLED_READLINE}
EXCLUDE+=	readline
.endif

.if ! ${PORT_OPTIONS:MBUNDLED_ZLIB}
EXCLUDE+=	zlib
.endif

.if ${ARCH} == "amd64"
CONFIGURE_TARGET=	x86_64-portbld-freebsd10.4
.endif

.if ${COMPILER_TYPE} == "clang"
CFLAGS+=	-Wno-extended-offsetof
.endif

post-patch:
	@${REINPLACE_CMD} -e 's|$$| [GDB v${PORTVERSION} for MidnightBSD]|' \
		${WRKSRC}/gdb/version.in

post-patch-KGDB-on:
	@${CP} -r ${FILESDIR}/kgdb/*.[ch] ${WRKSRC}/gdb/
	@${PATCH} -d ${PATCH_WRKSRC} ${PATCH_ARGS} < ${FILESDIR}/extrapatch-kgdb

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/gdb/gdb \
		${STAGEDIR}${PREFIX}/bin/gdb${VER}
	${INSTALL_MAN} ${WRKSRC}/gdb/doc/gdb.1 \
		${STAGEDIR}${MAN1PREFIX}/man/man1/gdb${VER}.1
	(cd ${WRKSRC}/gdb/data-directory ; \
		${SETENV} ${MAKE_ENV} ${MAKE_CMD} ${MAKE_ARGS} ${FAKE_MAKEARGS} install-syscalls )

do-install-KGDB-on:
	${INSTALL_PROGRAM} ${WRKSRC}/gdb/kgdb \
		${FAKE_DESTDIR}${PREFIX}/bin/kgdb${VER}
	${INSTALL_MAN} ${FILESDIR}/kgdb/kgdb.1 \
		${FAKE_DESTDIR}${MAN1PREFIX}/man/man1/kgdb${VER}.1

do-install-TUI-on:
	${LN} -sf gdb${VER} ${FAKE_DESTDIR}${PREFIX}/bin/gdbtui${VER}

do-install-GDB_LINK-on:
	${LN} -sf gdb${VER} ${FAKE_DESTDIR}${PREFIX}/bin/gdb
.if ${PORT_OPTIONS:MKGDB}
	${LN} -sf kgdb${VER} ${FAKE_DESTDIR}${PREFIX}/bin/kgdb
.endif

do-install-PYTHON-on:
	(cd ${WRKSRC}/gdb; ${SETENV} ${MAKE_ENV} ${MAKE_CMD} ${MAKE_ARGS} ${FAKE_MAKEARGS} install-python )
	(cd ${WRKSRC}/gdb/data-directory ; \
		${SETENV} ${MAKE_ENV} ${MAKE_CMD} ${MAKE_ARGS} ${FAKE_MAKEARGS} install-python )
. for f in gdb gdb/command gdb/function gdb/printer
	@(cd ${FAKE_DESTDIR}${PREFIX}/share/gdb${VER}/python/${f} ; ${CHMOD} 644 *.py* )
. endfor

do-install-GUILE-on:
	(cd ${WRKSRC}/gdb; ${SETENV} ${MAKE_ENV} ${MAKE_CMD} ${MAKE_ARGS} ${FAKE_MAKEARGS} install-guile )
	(cd ${WRKSRC}/gdb/data-directory ; \
		${SETENV} ${MAKE_ENV} ${MAKE_CMD} ${MAKE_ARGS} ${FAKE_MAKEARGS} install-guile )

.include <bsd.port.post.mk>
