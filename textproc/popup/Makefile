# New ports collection makefile for:    popup
# Date created:         18 Dec 2006
# Whom:                 dirk.meyer@dinoex.sub.org
#

#

PORTNAME=	popup
PORTVERSION=	0.5
PORTREVISION=	2
CATEGORIES=	textproc gnustep
MASTER_SITES=	SF/${PORTNAME}/${PORTNAME}/Popup-${PORTVERSION}pre1
DISTNAME=	Popup-${PORTVERSION}pre1

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Interactive learning aid for pairs of words

LICENSE=	gpl2 # or later

USES=		gnustep
USE_GNUSTEP=	back build

post-install:
	${STRIP_CMD} ${PREFIX}/GNUstep/System/Applications/Popup.app/Popup

.include <bsd.port.mk>
