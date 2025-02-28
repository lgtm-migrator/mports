# Created by: Kubilay Kocak <koobs@FreeBSD.org>

PORTNAME=	aiohttp
PORTVERSION=	3.8.1
CATEGORIES=	www python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Async http client/server framework (asyncio)

LICENSE=	apache2
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}attrs>=17.3.0:devel/py-attrs@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}chardet>=2.0:textproc/py-chardet@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}multidict>=4.5:www/py-multidict@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}async_timeout>=3.0:devel/py-async_timeout@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}yarl>=1.0:www/py-yarl@${PY_FLAVOR}

USES=		python:3.7+
USE_PYTHON=	autoplist distutils cython

.include <bsd.port.pre.mk>

pre-configure:
	@${TOUCH} ${WRKSRC}/aiohttp/*.pyx

post-install:
	${STRIP_CMD} ${FAKE_DESTDIR}${PYTHONPREFIX_SITELIBDIR}/aiohttp/*.so

.include <bsd.port.post.mk>
