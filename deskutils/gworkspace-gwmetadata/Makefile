PORTNAME=	gworkspace
PORTVERSION=	0.9.4
CATEGORIES=	deskutils gnustep
#MASTER_SITES=	http://www.gnustep.it/enrico/gworkspace/
MASTER_SITES=	GNUSTEP/usr-apps
PKGNAMESUFFIX=	-gwmetadata${PKGNAMESUFFIX2}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	GWMetadata for GNUstep workspace manager

LICENSE=	gpl2

USES=		gnustep sqlite
USE_GNUSTEP=	back build
GNU_CONFIGURE=	yes
LIB_DEPENDS=	libDBKit.so:deskutils/gworkspace \
		libPreferencePanes.so:deskutils/systempreferences
USE_LDCONFIG=	${GNUSTEP_SYSTEM_LIBRARIES}

USE_SQLITE=	yes
LDFLAGS+=	-lpthread

WRKSRC=		${WRKDIR}/gworkspace-${PORTVERSION}/GWMetadata
CONFIGURE_ARGS+=	--with-sqlite-include=${LOCALBASE}/include
CONFIGURE_ARGS+=	--with-sqlite-library=${LOCALBASE}/lib
DEFAULT_LIBVERSION=	0.1.0
MAKE_ENV+=	GNUSTEP_INSTALLATION_DOMAIN=SYSTEM

post-patch:
	${CP} ${WRKSRC}/gmds/mdextractor/Extractors/JpegExtractor/GNUmakefile.in \
		${WRKSRC}/gmds/mdextractor/Extractors/JpegExtractor/GNUmakefile
	${CP} ${FILESDIR}/Preferences-GNUmakefile \
		${WRKSRC}/Preferences/GNUmakefile
	${CP} ${FILESDIR}/MDFinder-GNUmakefile \
		${WRKSRC}/MDFinder/GNUmakefile

.include <bsd.port.mk>
