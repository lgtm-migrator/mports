PORTNAME=	unixODBC
PORTVERSION=	2.3.9
PORTREVISION=	0
CATEGORIES=	databases
MASTER_SITES=	http://www.unixodbc.org/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	ODBC library suite for Unix

LICENSE=	lgpl

CONFLICTS=	libiodbc-[0-9]* virtuoso-*

USES=		cpe iconv libtool:keepla
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-static --enable-shared \
		--with-libiconv-prefix=${LOCALBASE}
CONFIGURE_ENV=	ac_cv_header_msql_h=no
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd10.4
USE_LDCONFIG=	yes

PORTDOCS=	*

post-patch:
	@${REINPLACE_CMD} -e 's|\.ini$$|.ini.sample|' ${WRKSRC}/Makefile.in
	touch ${WRKSRC}/Interix/config.sub

post-install:
.if !defined(NOPORTDOCS)
	@${MKDIR} ${DOCSDIR}
	${TAR} -C ${WRKSRC}/doc --exclude '*Makefile*' -cf - . \
		| ${TAR} -C ${DOCSDIR} --unlink -xf -
.if !defined(INSTALL_AS_USER)
	@${CHOWN} -R ${SHAREOWN}:${SHAREGRP} ${DOCSDIR}
	${FIND} ${DOCSDIR} -type d -print0 | ${XARGS} -0 ${CHMOD} 755
	${FIND} ${DOCSDIR} -type f -print0 | ${XARGS} -0 ${CHMOD} 644
.endif
.endif

.include <bsd.port.mk>
