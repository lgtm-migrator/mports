

PORTNAME=	encore
PORTVERSION=	0.3.1
PORTREVISION=	1
CATEGORIES=	devel gnustep
MASTER_SITES=	SF/fortytwo/Encore/${PORTVERSION}
PKGNAMEPREFIX=	fortytwo-
DISTFILES=	Encore-${PORTVERSION}-src.tgz \
		Encore-${PORTVERSION}-api-ref.tgz

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Utility classes for GNUstep

LICENSE=	lgpl2.1
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		gnustep
USE_GNUSTEP=	back build
DEFAULT_LIBVERSION=	0.1
USE_LDCONFIG=	${GNUSTEP_LOCAL_LIBRARIES}

WRKSRC=		${WRKDIR}/Encore
DOCSDIR=	${GNUSTEP_PREFIX}/Local/Library/Documentation/Encore

PORTDOCS=	*

OPTIONS_DEFINE=	DOCS

post-install:
	@${MKDIR} ${DOCSDIR}
	cd ${WRKDIR}/Encore-${PORTVERSION}-api-ref && ${COPYTREE_SHARE} . ${DOCSDIR}
	${STRIP_CMD} ${PREFIX}/GNUstep/System/Library/Frameworks/Encore.framework/Versions/0/libEncore.so

.include <bsd.port.mk>
