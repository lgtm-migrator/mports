# Created by: Hirohisa Yamaguchi <umq@ueo.co.jp>

PORTNAME=	batv-milter
PORTVERSION=	0.5.0
PORTREVISION=	0
CATEGORIES=	mail
MASTER_SITES=	SF

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Milter for BATV (Bounce Address Tag Validation)

.if !exists( /usr/include/libmilter/mfapi.h )
BUILD_DEPENDS+=	${LOCALBASE}/include/libmilter/mfapi.h:mail/libmilter
.endif

USES=		uidfix ssl
USE_RC_SUBR=	milter-batv

MAKE_ARGS=	UBINOWN=${UID} UBINGRP=0
CFLAGS+=	-D_WANT_SEMUN

WCONF=		${WRKSRC}/devtools/Site
PLIST_FILES=	bin/batv-filter man/man8/batv-filter.8.gz
PORTDOCS=	INSTALL KNOWNBUGS LICENSE README RELEASE_NOTES \
		draft-levine-smtp-batv-01.txt

SITE=		${FILESDIR}/site.config.m4
SITE_SUB=	-e "s|%%PREFIX%%|${PREFIX}|g" \
		-e "s|%%LOCALBASE%%|${LOCALBASE}|g" \
		-e "s|%%OPENSSLINC%%|${OPENSSLINC}|g" \
		-e "s|%%OPENSSLLIB%%|${OPENSSLLIB}|g"

OPTIONS_DEFINE=	DOCS

.include <bsd.port.pre.mk>
.include "${PORTSDIR}/mail/sendmail/bsd.milter.mk"

.if defined(WITH_DEBUG)
SITE_SUB+=	-e '\|confOPTIMIZE.*-g|s/^dnl //g'
.endif

pre-configure:
	${CP} ${WRKSRC}/devtools/OS/FreeBSD ${WRKSRC}/devtools/OS/MidnightBSD
.if !exists( /usr/include/libmilter/mfapi.h )
	${REINPLACE_CMD} -e '/sendmail/ s|dnl ||; \
		s|/usr/local/sendmail|${LOCALBASE}|' \
		${WRKSRC}/batv-filter/Makefile.m4
.endif
	${SED} ${SITE_SUB} -e '\|^dnl |d' -e '/^dnl$$/d' \
		${SITE} > ${WCONF}/site.config.m4

post-install:
.if !defined(WITH_DEBUG)
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/batv-filter
.endif
	-${RM} ${MANPREFIX}/man/cat8/batv-filter.8 ${MANPREFIX}/man/cat8/batv-filter.8.gz
	${INSTALL_MAN} ${WRKSRC}/*/batv-filter.8 ${STAGEDIR}${MANPREFIX}/man/man8/
	${MKDIR} ${STAGEDIR}${DOCSDIR}
.for f in ${PORTDOCS}
	${INSTALL_DATA} ${WRKSRC}/${f} ${STAGEDIR}${DOCSDIR}
.endfor

.include <bsd.port.post.mk>
