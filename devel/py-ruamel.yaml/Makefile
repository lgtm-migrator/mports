# Created by: Mark Felder <feld@FreeBSD.org>

PORTNAME=	ruamel.yaml
PORTVERSION=	0.16.12
CATEGORIES=	devel python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	YAML 1.2 loader/dumper package for Python

LICENSE=	mit

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}ruamel.yaml.clib>=0.1.2:devel/py-ruamel.yaml.clib@${PY_FLAVOR}

USES=		python:3.6+
USE_PYTHON=	distutils autoplist

NO_ARCH=	yes

post-extract:
	@${RM} ${WRKSRC}/LICENSE

.include <bsd.port.mk>
