
#

PORTNAME=	wmtunlo
PORTVERSION=	0.1.3
PORTREVISION=	3
CATEGORIES=	misc windowmaker
MASTER_SITES=	http://www.gnu-darwin.org/distfiles/ \
		http://cvsup.theplanet.com/distfiles/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Falling-down-a-tunnel dockapp

LICENSE=        gpl2

USE_XORG=	x11 xpm xorgproto
ALL_TARGET=	wmtunlo

OPTIONS_DEFINE=	EXAMPLES

do-install:
	@${INSTALL_PROGRAM} ${WRKSRC}/wmtunlo ${PREFIX}/bin
	@${MKDIR} ${EXAMPLESDIR}
	@${INSTALL_SCRIPT} ${WRKSRC}/examples/* \
		${EXAMPLESDIR}

.include <bsd.port.mk>
