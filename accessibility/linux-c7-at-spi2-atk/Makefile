PORTNAME=	at-spi2-atk
PORTVERSION=	2.26.2
DISTVERSIONSUFFIX=	-1.el7
CATEGORIES=	accessibility linux

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Assistive technology ATK bridge (Linux CentOS ${LINUX_DIST_VER})

LICENSE=	lgpl

USES=		linux:c7
USE_LDCONFIG=	yes
USE_LINUX=	at-spi2-core atk dbuslibs
USE_LINUX_RPM=	yes

DESCR=		${.CURDIR}/../${PORTNAME}/pkg-descr

OPTIONS_DEFINE=	DOCS

.include <bsd.port.mk>
