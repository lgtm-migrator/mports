PORTNAME=	pypa-docs-theme
DISTVERSION=	g20180622
CATEGORIES=	textproc python
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Common base Sphinx theme for PyPA projects

LICENSE=	python
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}python-docs-theme>=0:textproc/py-python-docs-theme@${PY_FLAVOR}

USES=		python:3.6+
USE_PYTHON=	distutils autoplist
USE_GITHUB=	yes
GH_ACCOUNT=	pypa
GH_TAGNAME=	d2e63fb

NO_ARCH=	yes
NO_TEST=	yes

.include <bsd.port.mk>
