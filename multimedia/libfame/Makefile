

PORTNAME=	libfame
PORTVERSION=	0.9.1
PORTREVISION=	4
CATEGORIES=	multimedia
MASTER_SITES=	SF/fame/${PORTNAME}/${PORTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Video encoding library

LICENSE=	lgpl

GNU_CONFIGURE=	yes
INSTALL_TARGET=	install-strip
USES=		libtool
USE_LDCONFIG=	yes

OPTIONS_DEFINE=	MMX
OPTIONS_DEFAULT=MMX

MMX_CONFIGURE_ENABLE=	mmx

post-patch:
	@${REINPLACE_CMD} \
		-e 's|AC_DEFUN(AM_PATH_LIBFAME|AC_DEFUN([AM_PATH_LIBFAME]|g' \
		${WRKSRC}/libfame.m4 ${WRKSRC}/libfame.m4.in

.include <bsd.port.mk>
