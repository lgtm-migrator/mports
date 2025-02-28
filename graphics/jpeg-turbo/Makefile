PORTNAME=	jpeg-turbo
DISTVERSION=	2.1.4
PORTREVISION?=	0
CATEGORIES=	graphics
MASTER_SITES=	SF/lib${PORTNAME}/${DISTVERSION}
DISTNAME=	lib${PORTNAME}-${DISTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT?=	SIMD-accelerated JPEG codec which replaces libjpeg
WWW?=		https://libjpeg-turbo.org/

LICENSE=	bsd3 IJG zlib
LICENSE_COMB=	multi
LICENSE_GROUPS_IJG=	FSF GPL
LICENSE_NAME_IJG=	Independent JPEG Group License
LICENSE_FILE_bsd3=	${WRKSRC}/LICENSE.md
LICENSE_FILE_IJG=	${WRKSRC}/README.ijg
LICENSE_FILE_zlib=	${WRKSRC}/LICENSE.md
LICENSE_PERMS_IJG=	dist-mirror dist-sell pkg-mirror pkg-sell auto-accept

USES=		cmake cpe
USE_LDCONFIG=	yes
CMAKE_ON=	WITH_JPEG8
CPE_PRODUCT=	libjpeg-turbo
TEST_TARGET=	test

PORTDOCS=	*
DOCSDIR=	${PREFIX}/share/doc/libjpeg-turbo

OPTIONS_DEFINE=	DOCS

.include <bsd.mport.options.mk>

.if ${ARCH} == i386 || ${ARCH} == amd64
BUILD_DEPENDS+=	nasm:devel/nasm
.endif

.if ${ARCH} == armv6
CMAKE_OFF=	WITH_SIMD
.endif

.if ${SLAVE_PORT} == yes
PLIST_SUB+=	JPEG="@comment " LIBTURBOJPEG=""
.else
CMAKE_OFF+=	WITH_TURBOJPEG
CONFLICTS_INSTALL=	mozjpeg jpeg-[0-9]*
PLIST_SUB+=	JPEG="" LIBTURBOJPEG="@comment "
.endif

.include <bsd.port.mk>
