# Created by: Kubilay Kocak <koobs@FreeBSD.org>

PORTNAME=		spidermonkey185
PORTVERSION=		1.8.5
PORTREVISION=		3
CATEGORIES=		lang
MASTER_SITES=		MOZILLA/js
DISTNAME=		js185-1.0.0

MAINTAINER=		ports@MidnightBSD.org
COMMENT=		Standalone JavaScript (1.8.5) interpreter from Mozilla

LICENSE=		gpl2 mpl
LICENSE_COMB=		dual

BUILD_DEPENDS=		zip:archivers/zip \
			autoconf2.13:devel/autoconf2.13
LIB_DEPENDS=		libnspr4.so:devel/nspr

CONFLICTS=		njs-[0-9]*

USES=			gmake pathfix perl5 pkgconfig python:2.7,build
GNU_CONFIGURE=		yes
USE_LDCONFIG=		yes
USE_PERL5=		build

WRKSRC=			${WRKDIR}/js-${PORTVERSION}/js/src

CONFIGURE_ARGS=		--with-pthreads \
			--with-system-nspr
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd10.4

# This comes from bsd.gecko.mk, fixes linking issues on 9.0 and higher.
post-configure:
	${ECHO_CMD} "fenv.h" >> ${WRKSRC}/config/system-headers
	${ECHO_CMD} "pthread_np.h" >> ${WRKSRC}/config/system-headers

OPTIONS_DEFINE=		DEBUG GCZEAL JEMALLOC METHODJIT OPTIMIZE READLINE \
			THREADSAFE TRACEJIT UTF8 \

OPTIONS_DEFAULT=	METHODJIT OPTIMIZE READLINE THREADSAFE TRACEJIT

GCZEAL_DESC=		Enable Zealous garbage collecting
JEMALLOC_DESC=		Use jemalloc as memory allocator
METHODJIT_DESC=		Enable method JIT support
OPTIMIZE_DESC=		Enable compiler optimizations
READLINE_DESC=		Link js shell to system readline library
THREADSAFE_DESC=	Enable multiple thread support
TRACEJIT_DESC=		Enable tracing JIT support
UTF8_DESC=		Treat strings as UTF8 instead of ISO-8859-1

DEBUG_CONFIGURE_ENABLE=	debug
DEBUG_CONFIGURE_ON=	--enable-debug-sumbols
GCZEAL_CONFIGURE_ENABLE=	gczeal
JEMALLOC_CONFIGURE_ENABLE=	jemalloc
METHODJIT_CONFIGURE_ENABLE=	methodjit
OPTIMIZE_CONFIGURE_ENABLE=	optimize
READLINE_CONFIGURE_ENABLE=	readline
READLINE_USES=	readline
THREADSAFE_CONFIGURE_ENABLE=	threadsafe
TRACEJIT_CONFIGURE_ENABLE=	tracejit
UTF8_CFLAGS=			-DJS_C_STRINGS_ARE_UTF8

.include <bsd.mport.options.mk>

.if ${ARCH} == amd64
CONFIGURE_TARGET=	x86_64-portbld-freebsd${OSREL}
.endif

.if ${ARCH} == "amd64"
PLIST_SUB+=	AMD64=""
.else
PLIST_SUB+=	AMD64="@comment "
.endif

.if ${ARCH} == "i386"
PLIST_SUB+=	I386=""
.else
PLIST_SUB+=	I386="@comment "
.endif

.if ${ARCH} == "arm"
PLIST_SUB+=	ARM=""
.else
PLIST_SUB+=	ARM="@comment "
.endif

.if ${ARCH} == "mips"
PLIST_SUB+=	MIPS=""
.else
PLIST_SUB+=	MIPS="@comment "
.endif

.if ${ARCH} == "powerpc" || ${ARCH} == "powerpc64"
PLIST_SUB+=	PPC=""
.else
PLIST_SUB+=	PPC="@comment "
.endif

.if ${ARCH} == "sparc64"
PLIST_SUB+=	SPARC=""
.else
PLIST_SUB+=	SPARC="@comment "
.endif

pre-configure:
	(cd ${WRKSRC} && ${LOCALBASE}/bin/autoconf2.13)

regression-test: build
	@${ECHO_MSG} -n "===> Running jstests.py: "
	@cd ${WRKSRC} && ${SETENV} TZ=PST8PDT ${PYTHON_CMD} tests/jstests.py \
	--no-progress --worker-count=${MAKE_JOBS_NUMBER} ./js
.if ${PORT_OPTIONS:MMETHODJIT} || ${PORT_OPTIONS:MTRACEJIT}
	@${ECHO_MSG} -n "===> Running jit_test.py: "
	@cd ${WRKSRC} && ${SETENV} TZ=PST8PDT ${PYTHON_CMD} jit-test/jit_test.py \
	--no-progress --jitflags=,m,j,mj,mjp,am,amj,amjp,amd ./js
.endif

post-install:
	${LN} -sf libmozjs185.so.1.0.0 ${STAGEDIR}${PREFIX}/lib/libmozjs185.so
	${LN} -sf libmozjs185.so.1.0.0 ${STAGEDIR}${PREFIX}/lib/libmozjs185.so.1
	${LN} -sf libmozjs185.so.1.0.0 ${STAGEDIR}${PREFIX}/lib/libmozjs185.so.1.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libmozjs185.so.1.0.0

.include <bsd.port.mk>
