

PORTNAME=	jakarta-regexp
PORTVERSION=	1.5
PORTREVISION=	1
CATEGORIES=	java devel
MASTER_SITES=	${MASTER_SITE_APACHE_JAKARTA}
MASTER_SITE_SUBDIR=	regexp/binaries

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Regular expressions for Java

LICENSE=        apache2

BUILD_DEPENDS=	${LOCALBASE}/bin/ant:${PORTSDIR}/devel/apache-ant

USE_JAVA=	yes
JAVA_VERSION=	1.6+

PLIST=	${WRKDIR}/PLIST

JAVALIBNAME=	${PORTNAME}-${PORTVERSION}

.if !defined(NOPORTDOCS)
PORTDOCS=	*
.endif

do-build:
	@if [ ! -f ${WRKSRC}/lib ]; then ${MKDIR} ${WRKSRC}/lib; fi
	@cd ${WRKSRC} && \
		${SETENV} JAVA_HOME=${JAVA_HOME} ant -Djakarta-site.dir=${WRKSRC} test package

pre-install:
	@${RM} -f ${PLIST}
	@${TOUCH} ${PLIST}
	@${ECHO} ${JAVAJARDIR}/${PORTNAME}.jar | \
		${SED} "s,${PREFIX}/*,," >> ${PLIST}
	@${ECHO} "@unexec ${RMDIR} ${JAVAJARDIR} 2>/dev/null || true" | \
		${SED} "s,${PREFIX}/*,," >> ${PLIST}

do-install: do-install-jar do-install-apidocs

do-install-jar:
	@${MKDIR} ${JAVAJARDIR}
	@${INSTALL_DATA} ${WRKSRC}/${PORTNAME}-${PORTVERSION}.jar ${JAVAJARDIR}/${PORTNAME}.jar

do-install-apidocs:
.if !defined(NOPORTDOCS)
	@${MKDIR} ${DOCSDIR}
	@${CP} -r ${WRKSRC}/docs/api/* ${DOCSDIR}
	@${CHOWN} -h -R ${SHAREOWN}:${SHAREGRP} ${DOCSDIR}
.endif

.include <bsd.port.mk>
