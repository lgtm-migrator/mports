# New ports collection makefile for:	furl
# Date created:				3 January 2007
# Whom:					Phil Pereira <phil@bsdnexus.com>

PORTNAME=	furl
PORTVERSION=	2.1
CATEGORIES=	www
#MASTER_SITES=	http://www.gumbynet.org.uk/software/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Utility to display the HTTP headers returned by web-servers

LICENSE=	gpl2

GNU_CONFIGURE=	yes
CONFIGURE_TARGET=       ${MACHINE_ARCH}-portbld-midnightbsd${OSREL}

USE_GITHUB=     yes
GH_ACCOUNT=     bingos
GH_PROJECT=     ${PORTNAME}
GH_TAGNAME=	e5c824f

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

.include <bsd.port.mk>
