# Created by: Kubilay Kocak <koobs@FreeBSD.org>

PORTNAME=	boto3
PORTVERSION=	1.17.64
CATEGORIES=	www python devel
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	AWS SDK for Python

LICENSE=	apache2
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}botocore>=1.4.1:devel/py-botocore@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}jmespath>=0.7.1:devel/py-jmespath@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}s3transfer>=0.1.0:net/py-s3transfer@${PY_FLAVOR}
TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}nose>0:devel/py-nose@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}mock>0:devel/py-mock@${PY_FLAVOR}

USES=		python:3.6+
USE_GITHUB=	yes
USE_PYTHON=	autoplist distutils

GH_ACCOUNT=	boto

NO_ARCH=	yes

.if defined(MAGUS)
NO_TEST=	yes
.endif

# setup.py test runs integration tests which fail
# https://github.com/boto/s3transfer/issues/41
# Note: this is an AWS python package wide issue
do-test:
	@cd ${WRKSRC} && ${PYTHON_CMD} -m nose -v tests/unit tests/functional

.include <bsd.port.mk>
