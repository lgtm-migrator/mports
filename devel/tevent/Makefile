PORTNAME=		tevent
PORTVERSION=		0.10.2
PORTREVISION=		1
PORTEPOCH=		0
CATEGORIES=		devel
MASTER_SITES=		SAMBA

MAINTAINER=		ports@MidnightBSD.org
COMMENT=		Talloc based event loop library

LICENSE=		lgpl3

IGNORE_NONTHREAD_PYTHON=needs port lang/python${PYTHON_SUFFIX} to be build with THREADS support

BUILD_DEPENDS=		talloc>=2.3.1:devel/talloc
RUN_DEPENDS=		talloc>=2.3.1:devel/talloc

CONFLICTS_INSTALL=	tevent1-*

#FLAVORS=		default nopython
#nopython_PKGNAMESUFFIX=	-nopython
#nopython_CONFLICTS=	tevent
#default_CONFLICTS=	tevent-nopython

USES=			compiler gettext-runtime pkgconfig waf
USE_LDCONFIG=		yes
WAF_CMD=		buildtools/bin/waf
CONFIGURE_LOG=		bin/config.log

PKGCONFIGDIR?=		${PREFIX}/libdata/pkgconfig
PLIST_SUB+=		PKGCONFIGDIR=${PKGCONFIGDIR:S;${PREFIX}/;;}

CONFIGURE_ARGS+=	--bundled-libraries=!talloc

CONFIGURE_ARGS+=	--mandir=${MANPREFIX}/man \
			--disable-rpath \
			--without-gettext

OPTIONS_DEFINE=		MANPAGES DEBUG
MANPAGES_DESC=		Build and install manpages (requires textproc/docbook-xsl)

DEBUG_CONFIGURE_ON=	--verbose --enable-debug
DEBUG_MAKE_ARGS=	--verbose
DEBUG_FLAGS=		-g -ggdb3 -O0

.include <bsd.mport.options.mk>

PLIST_FILES+=		include/tevent.h \
			lib/libtevent.so \
			lib/libtevent.so.0 \
			libdata/pkgconfig/tevent.pc

.if defined(NO_PYTHON)
USES+=			python:build,test
CONFIGURE_ARGS+=	--disable-python
.else
USES+=			python:3.7+
USE_PYTHON=		py3kplist

PLIST_FILES+=		${PYTHON_SITELIBDIR:S;${LOCALBASE}/;;}/_tevent${PYTHON_EXT_SUFFIX}.so \
			${PYTHON_SITELIBDIR:S;${LOCALBASE}/;;}/tevent.py \
			${PYTHON_SITELIBDIR:S;${LOCALBASE}/;;}/__pycache__/tevent.cpython-${PYTHON_SUFFIX}.pyc
.endif

.include <bsd.port.pre.mk>

.if ! ${PORT_OPTIONS:MMANPAGES}
CONFIGURE_ENV+=		XSLTPROC="true"
.else
BUILD_DEPENDS+=		${LOCALBASE}/share/xsl/docbook/manpages/docbook.xsl:textproc/docbook-xsl \
			xsltproc:textproc/libxslt
.endif
# No fancy color error messages
.if ${COMPILER_TYPE} == "clang"
CFLAGS+=		-fno-color-diagnostics
.endif
CONFIGURE_ENV+=		NOCOLOR=yes
MAKE_ENV+=		NOCOLOR=yes

post-patch:
			@${REINPLACE_CMD} -e 's|%%PKGCONFIGDIR%%|${PKGCONFIGDIR}|g' \
				${BUILD_WRKSRC}/wscript

# Use threading (or multiprocessing) but not thread (renamed in python 3+).
pre-configure:
			@if ! ${PYTHON_CMD} -c "import multiprocessing;" 2>/dev/null; then \
				${ECHO_CMD}; \
				${ECHO_MSG} "===>  ${PKGNAME} "${IGNORE_NONTHREAD_PYTHON:Q}.; \
				${ECHO_CMD}; \
				${FALSE}; \
			fi

post-install:
			${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libtevent.so
.if !defined(NO_PYTHON)
			${STRIP_CMD} ${FAKE_DESTDIR}${PYTHONPREFIX_SITELIBDIR}/_tevent*.so
			${PYTHON_CMD} -m compileall -d ${PYTHON_SITELIBDIR} ${FAKE_DESTDIR}${PYTHON_SITELIBDIR}
.endif

.include <bsd.port.post.mk>
