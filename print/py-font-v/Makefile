# Created by: Po-Chuan Hsieh <sunpoet@FreeBSD.org>

PORTNAME=	font-v
PORTVERSION=	1.0.5
CATEGORIES=	print python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Font version reporting and modification tool

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/docs/LICENSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}fonttools>=0:print/py-fonttools@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}GitPython>=0:devel/py-gitpython@${PY_FLAVOR}

USES=		python:3.6+
USE_PYTHON=	autoplist concurrent distutils

NO_ARCH=	yes

.include <bsd.port.mk>
