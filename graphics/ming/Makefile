PORTNAME=	ming
DISTVERSIONPREFIX=	${PORTNAME}-
DISTVERSION=	0_4_8
PORTREVISION=	2
CATEGORIES=	graphics

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Flash 4/5 movie output library with many languages support

LICENSE=	gpl2 lgpl2.1
LICENSE_COMB=	multi

LIB_DEPENDS=	libfreetype.so:print/freetype2 \
		libgif.so:graphics/giflib \
		libpng.so:graphics/png

CONFLICTS_INSTALL=	ja-ming-[0-9]*

OPTIONS_DEFINE=	DOCS

PORTSCOUT=	limit:^ming-

CFLAGS+=	-fcommon # https://github.com/libming/libming/issues/55
CONFIGURE_ARGS=	--includedir=${PREFIX}/include/ming
GNU_CONFIGURE=	yes
INSTALL_TARGET=	install-strip
MAKE_JOBS_UNSAFE=	yes
PATHFIX_MAKEFILEIN=	Makefile.am
USE_LDCONFIG=	yes
USES=		autoreconf bison gmake libtool localbase pathfix shebangfix

PORTDOCS=	*

USE_GITHUB=	yes
GH_ACCOUNT=	lib${PORTNAME}
GH_PROJECT=	lib${PORTNAME}

SHEBANG_FILES=	util/cws2fws

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/include/ming/ ${STAGEDIR}${PREFIX}/include/ming/blocks/ ${STAGEDIR}${PREFIX}/include/ming/util/
	cd ${WRKSRC}/util/ && ${INSTALL_SCRIPT} cws2fws ming-config ${STAGEDIR}${PREFIX}/bin/
	cd ${WRKSRC}/ && ${INSTALL_DATA} *.h src/*.h ${STAGEDIR}${PREFIX}/include/ming/
	cd ${WRKSRC}/src/blocks/ && ${INSTALL_DATA} *.h ${STAGEDIR}${PREFIX}/include/ming/blocks/
	cd ${WRKSRC}/util/ && ${INSTALL_DATA} *.h ${STAGEDIR}${PREFIX}/include/ming/util/

post-install-DOCS-on:
	${MKDIR} ${STAGEDIR}${DOCSDIR}/ ${STAGEDIR}${DOCSDIR}/util/
	cd ${WRKSRC}/ && ${INSTALL_DATA} HISTORY NEWS README TODO ${STAGEDIR}${DOCSDIR}/
	cd ${WRKSRC}/util/ && ${INSTALL_DATA} README TIPS TODO swftoperl.html ${STAGEDIR}${DOCSDIR}/util/

.include <bsd.port.mk>
