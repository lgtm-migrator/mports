PORTNAME=	zope.schema
PORTVERSION=	4.2.2
CATEGORIES=	devel python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DIST_SUBDIR=	zope

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Zope Interface extension for defining data schemas

LICENSE=	zpl2.1

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}zope.interface>=3.6.0:devel/py-zope.interface@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}zope.event>=0:devel/py-zope.event@${PY_FLAVOR}

USES=		python:3.6+
USE_PYTHON=	distutils autoplist

NO_ARCH=	yes

.include <bsd.port.mk>
