# Created by: Mario Sergio Fujikawa Ferreira <lioux@FreeBSD.org>

PORTNAME=	gstreamer
PORTVERSION?=	${BASE_PORTVERSION}
# When chasing a shared library for a plug-in bump the PORTREVISION in the
# plug-in port instead, like ${category}/gstreamer1-plugin-${PLUGIN}.
PORTREVISION?=	2
CATEGORIES?=	multimedia audio
MASTER_SITES=	GNOME/sources/gst-plugins-base/${PORTVERSION:R}:base \
		GNOME/sources/gst-plugins-good/${PORTVERSION:R}:good \
		http://gstreamer.freedesktop.org/src/gst-plugins-base/:base \
		http://gstreamer.freedesktop.org/src/gst-plugins-bad/:bad \
		http://gstreamer.freedesktop.org/src/gst-plugins-good/:good \
		http://gstreamer.freedesktop.org/src/gst-plugins-ugly/:ugly
PKGNAMESUFFIX?=	1-plugins${GST_PLUGIN_SUFFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT?=	GStreamer written collection of plugins handling several media types

LICENSE=	lgpl

BUILD_DEPENDS+=	gstreamer1>=${GST1_VERSION}${GST1_MINIMAL_VERSION}:multimedia/gstreamer1 \
		iso-codes>=0:misc/iso-codes \
		orc>=0.4.16:devel/orc
LIB_DEPENDS+=	libgstreamer-1.0.so:multimedia/gstreamer1 \
		libfreetype.so:print/freetype2 \
		liborc-0.4.so:devel/orc
RUN_DEPENDS+=	iso-codes>=0:misc/iso-codes

PORTSCOUT=	limitw:1,even

BASE_PORTVERSION=	1.16.2
BASE_DISTNAME=		gst-plugins-base-${BASE_PORTVERSION}
BASE_DISTFILE=		${BASE_DISTNAME}${EXTRACT_SUFX}
BAD_PORTVERSION=	1.16.2
BAD_DISTNAME=		gst-plugins-bad-${BAD_PORTVERSION}
BAD_DISTFILE=		${BAD_DISTNAME}${EXTRACT_SUFX}
GOOD_PORTVERSION=	1.16.2
GOOD_DISTNAME=		gst-plugins-good-${GOOD_PORTVERSION}
GOOD_DISTFILE=		${GOOD_DISTNAME}${EXTRACT_SUFX}
UGLY_PORTVERSION=	1.16.2
UGLY_DISTNAME=		gst-plugins-ugly-${UGLY_PORTVERSION}
UGLY_DISTFILE=		${UGLY_DISTNAME}${EXTRACT_SUFX}
DIST?=		base

USES+=		cpe gettext gmake gnome libtool pathfix pkgconfig python tar:xz
WANT_GSTREAMER=	yes
USE_GNOME+=	glib20 introspection:build libxml2
GNU_CONFIGURE=	yes
INSTALL_TARGET=	install-strip
GST_PLUGIN?=	base
USE_LDCONFIG=	yes

CPE_VENDOR=	gstreamer_project
CPE_PRODUCT=	gstreamer

CFLAGS+=	-Wno-format
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-lpthread -L${LOCALBASE}/lib ${EXTRA_LIBS}

CONFIGURE_ARGS+=	--disable-fatal-warnings

DEFAULT_AUDIOSINK?=	osssink
DEFAULT_AUDIOSRC?=	osssrc

.if ${DIST}==""
IGNORE=		DIST not specified
.endif

VERSION=	1.0
SOVERSION=	0.1602.0
PLIST_SUB+=	VERSION="${VERSION}" \
		SOVERSION="${SOVERSION}"

.include <bsd.mport.options.mk>

.if ${GST_PLUGIN} == "base"
DIST=	base
NO_GSTREAMER_COMMON=	yes
.else
BUILD_DEPENDS+=	gstreamer1-plugins>=${GST1_VERSION}${GST1_MINIMAL_VERSION}:multimedia/gstreamer1-plugins
RUN_DEPENDS+=	gstreamer1-plugins>=${GST1_VERSION}${GST1_MINIMAL_VERSION}:multimedia/gstreamer1-plugins
.endif

.if ${DIST} == base || ${DIST} == ugly
#  --with-default-audiosink specify default audio sink
#  --with-default-audiosrc specify default audio source
#  --with-default-videosink specify default video sink
#  --with-default-videosrc specify default video source
#  --with-default-visualizer specify default visualizer
CONFIGURE_ARGS+=--with-default-audiosink="${DEFAULT_AUDIOSINK}" \
		--with-default-audiosrc="${DEFAULT_AUDIOSRC}"
.endif

.include "${MASTERDIR}/Makefile.common"

.if ${DIST}=="base"
EXTRACT_ONLY=${BASE_DISTFILE}
WRKSRC=${WRKDIR}/${BASE_DISTNAME}
PORTVERSION=	${BASE_PORTVERSION}
DISTFILES+=	${BASE_DISTFILE}:base
PATCHDIR=	${.CURDIR}/../../multimedia/gstreamer1-plugins/files
.elif ${DIST}=="bad"
EXTRACT_ONLY=${BAD_DISTFILE}
WRKSRC=${WRKDIR}/${BAD_DISTNAME}
PORTVERSION=	${BAD_PORTVERSION}
DISTFILES+=	${BAD_DISTFILE}:bad
PATCHDIR=	${.CURDIR}/../../multimedia/gstreamer1-plugins-bad/files
.elif ${DIST}=="ugly"
EXTRACT_ONLY=${UGLY_DISTFILE}
WRKSRC=${WRKDIR}/${UGLY_DISTNAME}
PORTVERSION=	${UGLY_PORTVERSION}
DISTFILES+=	${UGLY_DISTFILE}:ugly
PATCHDIR=	${.CURDIR}/../../multimedia/gstreamer1-plugins-ugly/files
.elif ${DIST}=="good"
EXTRACT_ONLY=${GOOD_DISTFILE}
WRKSRC=${WRKDIR}/${GOOD_DISTNAME}
PORTVERSION=	${GOOD_PORTVERSION}
DISTFILES+=	${GOOD_DISTFILE}:good
PATCHDIR=	${.CURDIR}/../../multimedia/gstreamer1-plugins-good/files
.elif ${DIST}=="makesum"
DISTFILES+=	${BASE_DISTFILE}:base ${BAD_DISTFILE}:bad \
		${UGLY_DISTFILE}:ugly ${GOOD_DISTFILE}:good
.else
BROKEN=		Unknown dist setting
.endif

# cdrom/dvd default device
.ifdef(WITH_DVD_DEVICE)
DEFAULT_DVD_DEVICE=${WITH_DVD_DEVICE}
.else
DEFAULT_DVD_DEVICE=/dev/cd0
.endif

post-patch:
.if ${DIST} == bad
# custom rule to fix opencv detection in configure
#	@${REINPLACE_CMD} -e 's|opencv <= 2.4.8|opencv <= 2.4.9|g' \
#		${WRKSRC}/configure
	@${REINPLACE_CMD} -e 's|/dev/dvd|${DEFAULT_DVD_DEVICE}|g' \
		${WRKSRC}/ext/resindvd/resindvdbin.c \
		${WRKSRC}/ext/resindvd/resindvdsrc.c
# Fix dependency on neon-0.31 and 0.32
	${REINPLACE_CMD} -e '/neon/s|0.30.99|0.32.99|g' \
		${WRKSRC}/configure
# Fix build against OpenCV 4.5.1
	 ${REINPLACE_CMD} '/opencv/s|4\.2\.0|4.6.0|g' \
		 ${WRKSRC}/configure

.endif
.if ${DIST} != ugly
	@${FIND} ${WRKSRC}/ext ${WRKSRC}/sys \
	-name Makefile.in | ${XARGS} -n 10 ${REINPLACE_CMD} -e \
	'/la_DEPENDENCIES/,/am__DEPENDENCIES/s,$$(top_builddir)/gst-libs/.*.la,,' -e \
	's|$$(top_builddir)/gst-libs/gst/tag/libgsttag-@GST_API_VERSION@.la|-lgsttag-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/audio/libgstaudio-@GST_API_VERSION@.la|-lgstaudio-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/pbutils/libgstpbutils-@GST_API_VERSION@.la|-lgstpbutils-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/riff/libgstriff-@GST_API_VERSION@.la|-lgstriff-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/signalprocessor/libgstsignalprocessor-@GST_API_VERSION@.la|-lgstsignalprocessor-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/video/libgstbasevideo-@GST_API_VERSION@.la|-lgstbasevideo-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/video/libgstvideo-@GST_API_VERSION@.la|-lgstvideo-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/base/libgstbadbase-@GST_API_VERSION@.la|-lgstbadbase-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/uridownloader/libgsturidownloader-@GST_API_VERSION@.la|-lgsturidownloader-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/adaptivedemux/libgstadaptivedemux-@GST_API_VERSION@.la|-lgstadaptivedemux-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/codecparsers/libgstcodecparsers-@GST_API_VERSION@.la|-lgstcodecparsers-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/allocators/libgstbadallocators-@GST_API_VERSION@.la|-lgstbadallocators-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/audio/libgstbadaudio-@GST_API_VERSION@.la|-lgstbadaudio-${VERSION}|; \
	s|$$(top_builddir)/gst-libs/gst/video/libgstbadvideo-@GST_API_VERSION@.la|-lgstbadvideo-${VERSION}|'

	 @${FIND} ${WRKSRC}/ext ${WRKSRC}/sys -name Makefile.in | \
	 ${XARGS} -n 10 ${REINPLACE_CMD} -e \
	'/la_DEPENDENCIES/,/am__DEPENDENCIES/s,$$(top_builddir)/gst-libs/.*.la,,' -e \
	 's|$$(top_builddir)/gst-libs/gst/tag/libgsttag-$$(GST_API_VERSION).la|-lgsttag-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/audio/libgstaudio-$$(GST_API_VERSION).la|-lgstaudio-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/pbutils/libgstpbutils-$$(GST_API_VERSION).la|-lgstpbutils-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/riff/libgstriff-$$(GST_API_VERSION).la|-lgstriff-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/signalprocessor/libgstsignalprocessor-$$(GST_API_VERSION).la|-lgstsignalprocessor-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/video/libgstbasevideo-$$(GST_API_VERSION).la|-lgstbasevideo-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/video/libgstvideo-$$(GST_API_VERSION).la|-lgstvideo-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/base/libgstbadbase-$$(GST_API_VERSION).la|-lgstbadbase-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/uridownloader/libgsturidownloader-$$(GST_API_VERSION).la|-lgsturidownloader-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/adaptivedemux/libgstadaptivedemux-@GST_API_VERSION@.la|-lgstadaptivedemux-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/codecparsers/libgstcodecparsers-$$(GST_API_VERSION).la|-lgstcodecparsers-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/allocators/libgstbadallocators-$$(GST_API_VERSION).la|-lgstbadallocators-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/audio/libgstbadaudio-$$(GST_API_VERSION).la|-lgstbadaudio-${VERSION}|; \
	  s|$$(top_builddir)/gst-libs/gst/video/libgstbadvideo-$$(GST_API_VERSION).la|-lgstbadvideo-${VERSION}|'
	@${FIND} ${WRKSRC}/ext ${WRKSRC}/gst ${WRKSRC}/gst-libs \
		-name Makefile.in -exec ${REINPLACE_CMD} \
		'/foreach/s/\\#include/#include/' {} +
.endif

.if ${DIST} == bad
# Disable X11 support in librfb
post-configure:
	@${REINPLACE_CMD} -e 's|HAVE_X11 = yes|HAVE_X11 = no|g' \
		-e 's|#ifdef HAVE_X11|#ifdef NO_X11|g' \
		-e 's|$$(X11_CFLAGS) \\|\\|g' \
		-e 's|$$(X11_LIBS) \\|\\|g' \
		${WRKSRC}/gst/librfb/Makefile \
		${WRKSRC}/gst/librfb/gstrfbsrc.c
.endif

pre-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/lib/gstreamer-1.0

.include <bsd.port.mk>
