# Created by: Murilo Opsfelder <mopsfelder@gmail.com>

PORTNAME=	ipaddr
PORTVERSION=	2.2.0
CATEGORIES=	devel python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Google open source IPv4/IPv6 manipulation library in Python

LICENSE=	apache2
LICENSE_FILE=	${WRKSRC}/COPYING

NO_ARCH=	yes
USES=		python:3.6+
USE_PYTHON=	distutils autoplist
TEST_ENV=	${MAKE_ENV} PYTHONPATH=${STAGEDIR}${PYTHONPREFIX_SITELIBDIR}

do-test:
	@(cd ${TEST_WRKSRC} && ${SETENV} ${TEST_ENV} ${PYTHON_CMD} ipaddr_test.py)

.include <bsd.port.mk>
