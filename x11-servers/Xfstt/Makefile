PORTNAME=	xfstt
PORTVERSION=	1.9.3
PORTREVISION=	1
CATEGORIES=	x11-servers
MASTER_SITES=	http://archive.hadrons.org/software/xfstt/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	TrueType font server for X11

LICENSE=	lgpl
LICENSE_FILE=	${WRKSRC}/COPYING.LIB

USES=		pkgconfig tar:xz xorg
USE_XORG=	xorgproto
USE_RC_SUBR=	xfstt
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--localstatedir=/var --disable-nls

TTFONTDIR=	${PREFIX}/share/fonts/TrueType

SUB_FILES=	pkg-message

OPTIONS_DEFINE=	DOCS

post-patch:
.for file in INSTALL doc/Makefile.in src/Makefile.in
	@${REINPLACE_CMD} -e 's|%%TTFONTDIR%%|${TTFONTDIR}|g' ${WRKSRC}/${file}
.endfor

post-install:
	${SED} -e "s:%%PREFIX%%:${PREFIX}:g" ${FILESDIR}/xfstt.in \
		> ${WRKSRC}/xfstt
	${INSTALL_SCRIPT} ${WRKSRC}/xfstt ${STAGEDIR}${PREFIX}/etc/rc.d/

post-install-DOCS-on:
	@${MKDIR} ${FAKE_DESTDIR}${DOCSDIR}
.for _file in INSTALL THANKS
	${INSTALL_DATA} ${WRKSRC}/${_file} ${FAKE_DESTDIR}${DOCSDIR}
.endfor

.include <bsd.port.mk>
