PORTNAME=	gmake
PORTVERSION=	4.3
PORTREVISION=	2
CATEGORIES=	devel
MASTER_SITES=	GNU/make
DISTNAME=	make-${PORTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	GNU version of 'make' utility

LICENSE=	gpl3
LICENSE_FILE=	${WRKSRC}/COPYING

GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--program-prefix=g \
		--without-guile

USES=		cpe tar:lz
CPE_VENDOR=	gnu
CPE_PRODUCT=	make

OPTIONS_DEFINE=	NLS
OPTIONS_SUB=	yes

NLS_USES=	gettext-runtime
NLS_CONFIGURE_ENABLE=	nls

INFO=		make

.include <bsd.port.mk>
