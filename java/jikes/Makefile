PORTNAME=	jikes
PORTVERSION=	1.22
PORTREVISION=	3
CATEGORIES=	java
MASTER_SITES=	SF/${PORTNAME}/Jikes/${PORTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Java source to byte-code compiler made available by IBM

LICENSE=	other

PLIST_SUB=	PORTVERSION=${PORTVERSION}
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	ac_cv_search_iconv=${ICONV_LIB} \
		ac_cv_search_libiconv_open=no
USES=		autoreconf iconv gmake tar:bzip2

CPPFLAGS+=	-I${LOCALBASE}/include
LIBS+=		-L${LOCALBASE}/lib

.include <bsd.port.mk>
