# Created by: Mark Felder <feld@FreeBSD.org>

PORTNAME=	invoke
PORTVERSION=	1.5.0
PORTREVISION=	2
CATEGORIES=	devel python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Python task execution tool & library

LICENSE=	bsd2
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		python:3.6+
USE_PYTHON=	autoplist concurrent distutils

NO_ARCH=	yes

post-patch:
	@${RM} -fr ${WRKSRC}/invoke/vendor/yaml2

.include <bsd.port.mk>
