# Created by: Kubilay Kocak <koobs@FreeBSD.org>

PORTNAME=	oauthlib
PORTVERSION=	1.1.2
CATEGORIES=	security net python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	RFC-compliant implementation of the OAuth request-signing logic

LICENSE=	bsd3
LICENSE_FILE=	${WRKSRC}/LICENSE

TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}nose>0:devel/py-nose@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}cryptography>0:security/py-cryptography@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}pyjwt>=1.0.0:www/py-pyjwt@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}blinker>0:devel/py-blinker@${PY_FLAVOR}

OPTIONS_DEFINE=		RSA SIGNALS SIGNEDTOKEN
OPTIONS_DEFAULT=	RSA SIGNALS SIGNEDTOKEN

RSA_DESC=		Enable RSA Support
SIGNALS_DESC=		Enable signal support
SIGNEDTOKEN_DESC=	Support for Signed Token

RSA_RUN_DEPENDS=		${PYTHON_PKGNAMEPREFIX}cryptography>0:security/py-cryptography@${PY_FLAVOR}
SIGNALS_RUN_DEPENDS=		${PYTHON_PKGNAMEPREFIX}blinker>0:devel/py-blinker@${PY_FLAVOR}
SIGNEDTOKEN_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}cryptography>0:security/py-cryptography@${PY_FLAVOR} \
				${PYTHON_PKGNAMEPREFIX}pyjwt>=1.0.0:www/py-pyjwt@${PY_FLAVOR}

USES=		python:3.6+
USE_PYTHON=	autoplist distutils

NO_ARCH=	yes
NO_TEST=	yes

.include <bsd.port.mk>
