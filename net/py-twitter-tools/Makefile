PORTNAME=	twitter
PORTVERSION=	1.18.0
DISTVERSIONPREFIX=	${PORTNAME}-
CATEGORIES=	net python
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
PKGNAMESUFFIX=	-tools

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Python API and command-line toolset for Twitter

TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}nose>0:devel/py-nose@${PY_FLAVOR}

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		python:3.6+
USE_PYTHON=	distutils concurrent autoplist
USE_GITHUB=	yes

GH_ACCOUNT=	sixohsix

NO_ARCH=	yes
NO_TEST=	yes

.include <bsd.port.mk>
