PORTNAME=	gmp
PORTVERSION=	6.2.1
CATEGORIES=	math devel
MASTER_SITES=	GNU

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Free library for arbitrary precision arithmetic

LICENSE=	lgpl3

OPTIONS_DEFINE=	CPU_OPTS
CPU_OPTS_DESC=	Enable assembly optimizations for your CPU

USES=		cpe libtool makeinfo tar:xz
HAS_CONFIGURE=	yes
CONFIGURE_ENV=	MAKEINFO="makeinfo --no-split"
CONFIGURE_ARGS=	--prefix=${PREFIX} \
		--infodir=${PREFIX}/info \
		--mandir=${PREFIX}/man \
		--enable-cxx
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd11.4
MAKE_JOBS_UNSAFE=yes
USE_LDCONFIG=	yes

CPE_VENDOR=	gmplib

INFO=		gmp

INSTALL_TARGET=	install-strip
TEST_TARGET=	check

.include <bsd.port.pre.mk>

.if ! ${PORT_OPTIONS:MCPU_OPTS}
CONFIGURE_ARGS+=--build=${CONFIGURE_TARGET}
.elif ${ARCH:S/64//} != ${ARCH}
.if ${ARCH} == powerpc64
CONFIGURE_ENV+=	ABI="mode64"
.else
CONFIGURE_ENV+=	ABI="64"
.endif
.else
CONFIGURE_ENV+=	ABI="32"
.endif

post-extract:
	@${RM} ${WRKSRC}/doc/gmp.info*

.include <bsd.port.post.mk>
