

PORTREVISION=	0
PKGNAMESUFFIX=	-gst1

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	GStreamer 1 plugin from libnice

LIB_DEPENDS=	libnice.so:${PORTSDIR}/net-im/libnice

MASTERDIR=	${.CURDIR}/../libnice
DESCR=		${.CURDIR}/pkg-descr
PLIST=		${.CURDIR}/pkg-plist

BUILD_WRKSRC=	${WRKSRC}/gst
INSTALL_WRKSRC=	${WRKSRC}/gst

LIBNICE_SLAVE=	gstreamer1

.include "${MASTERDIR}/Makefile"
