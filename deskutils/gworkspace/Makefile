# New ports collection makefile for:    gworkspace
# Date created:         04 Feb 2003
# Whom:                 dirk.meyer@dinoex.sub.org

PORTNAME=	gworkspace
PORTVERSION=	0.9.4
CATEGORIES=	deskutils gnustep
#MASTER_SITES=	http://www.gnustep.it/enrico/gworkspace/
MASTER_SITES=	GNUSTEP/usr-apps

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	GNUstep workspace manager

LICENSE=	gpl2

USES=		gnustep
USE_GNUSTEP=	back build
USE_LDCONFIG=	${GNUSTEP_SYSTEM_LIBRARIES}

GNU_CONFIGURE=	yes
ADDITIONAL_LDFLAGS+=	-L${WRKSRC}/FSNode/FSNode.framework/Versions/A

pre-configure:
	${RM} -rf ${WRKSRC}/GWMetadata

.include <bsd.port.mk>
