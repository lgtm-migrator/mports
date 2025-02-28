PORTNAME=	win32-codecs
DISTVERSION=	20110131
PORTREVISION=	1
PORTEPOCH=	1
CATEGORIES=	multimedia audio
MASTER_SITES=	http://www.mplayerhq.hu/MPlayer/releases/codecs/ \
		http://ftp.lug.udel.edu/MPlayer/releases/codecs/ \
		ftp://ftp.lug.udel.edu/MPlayer/releases/codecs/
DISTFILES=	all-${DISTVERSION}.tar.bz2 \
		${ADDITIONAL_CODECS_DISTFILES}
DIST_SUBDIR=	win32
EXTRACT_ONLY=	all-${DISTVERSION}.tar.bz2

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Huge compilation of Win32 binary video codecs

LICENSE=	unknown

RESTRICTED=	Unsure of codec license

USES=		tar:bzip2

ONLY_FOR_ARCHS=	i386
NO_BUILD=	yes
WRKSRC=		${WRKDIR}/w32codec-${DISTVERSION}

PLIST_SUB=	PKGNAME=${PKGNAME}

# Used by other ports to detect if this is installed
CODEC_DETECTION_FILE=	${LOCALBASE}/lib/win32/${PKGNAME}

# additional codec packs
ADDITIONAL_CODECS_DISTFILES=	xanimdlls-20040626.tar.bz2

# extraction wrksrc
ADDITIONAL_CODECS_WRKSRC=	${DISTFILES:S/.tar.bz2//}

# list of quicktime codecs that will be removed
REMOVE_CODECS_FILES=	AvidQTAVUICodec.qtx QuickTimeEssentials.qtx QuickTime.qts \
			QuickTimeInternetExtras.qtx qtmlClient.dll BeHereiVideo.qtx

OPTIONS_DEFINE=	REALPLAYER
OPTIONS_DEFAULT=	REALPLAYER
REALPLAYER_DESC=	Install realplayer codec

.include <bsd.mport.options.mk>

.if ${PORT_OPTIONS:MREALPLAYER}
ADDITIONAL_CODECS_DISTFILES+=	rp9codecs-20050115.tar.bz2 \
				rp9codecs-win32-20050115.tar.bz2
PLIST_SUB+=	REALPLAYER=""
.else
PLIST_SUB+=	REALPLAYER="@comment "
.endif

post-extract:
	@cd ${WRKDIR}/all-${DISTVERSION} && \
		${RM} ${REMOVE_CODECS_FILES}
.for file in ${ADDITIONAL_CODECS_DISTFILES}
	@cd ${WRKDIR} && ${TAR} xyf \
		${DISTDIR}/${DIST_SUBDIR}/${file}
.endfor
	@${MKDIR} ${WRKSRC}
.for dir in ${ADDITIONAL_CODECS_WRKSRC}
	@${INSTALL} ${WRKDIR}/${dir}/* ${WRKSRC}
.endfor

do-install:
	@${MKDIR} ${PREFIX}/lib/win32
.if ${PORT_OPTIONS:MREALPLAYER}
	@${INSTALL_DATA} ${WRKSRC}/* ${PREFIX}/lib/win32
.else
	@${INSTALL_DATA} ${WRKSRC}/*[^0] ${PREFIX}/lib/win32
.endif
# marker file
	@${CP} /dev/null ${PREFIX}/lib/win32/${PKGNAME}
	@${CHMOD} 0444 ${PREFIX}/lib/win32/${PKGNAME}

.include <bsd.port.mk>
