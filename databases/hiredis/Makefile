# Created by: Grzegorz Blach <gblach@FreeBSD.org>

PORTNAME=	hiredis
PORTVERSION=	0.13.3
DISTVERSIONPREFIX=v
CATEGORIES=	databases

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Minimalistic C client library for the Redis database

LICENSE=	bsd3

FAKE_OPTS=	trueprefix

USE_GITHUB=	yes
GH_ACCOUNT=	redis

USES=		gmake
USE_LDCONFIG=	yes

post-patch:
	@${REINPLACE_CMD} \
		-e '/^REAL_/s/ \$$(ARCH)//' \
		-e 's|\$$(INSTALL_LIBRARY_PATH)/\$$(PKGCONF_PATH)|\$$(DESTDIR)\$$(PREFIX)/libdata/\$$(PKGCONF_PATH)|' \
		${WRKSRC}/Makefile

post-build:
	@${STRIP_CMD} ${WRKSRC}/libhiredis.so

.include <bsd.port.mk>
