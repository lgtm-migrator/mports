# based on the OpenBSD port


PORTNAME=	mcrypt
PORTVERSION=	2.6.8
PORTREVISION=	4
CATEGORIES=	security
MASTER_SITES=	SF/${PORTNAME}/MCrypt/${PORTVERSION} \
		ftp://argeas.cs-net.gr/pub/unix/mcrypt/attic/ \
		ftp://ftp.ntua.gr/pub/security/mcrypt/ \
		ftp://mcrypt.hellug.gr/pub/mcrypt/attic/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Replacement for crypt(1)

LICENSE=	gpl3

LIB_DEPENDS=	libmcrypt.so:security/libmcrypt \
		libmhash.so:security/mhash

USES=		gettext
GNU_CONFIGURE=	yes
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib -lintl
CONFIGURE_ARGS=	--enable-static --with-catgets

post-patch:
	${REINPLACE_CMD} -e '/malloc\.h/d' ${WRKSRC}/src/rfc2440.c

post-install:
	@${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	@${INSTALL_DATA} ${WRKSRC}/doc/sample.mcryptrc ${STAGEDIR}${EXAMPLESDIR}
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	@cd  ${WRKSRC}/doc && ${INSTALL_DATA} FORMAT magic ${STAGEDIR}${DOCSDIR}

.include <bsd.port.mk>
