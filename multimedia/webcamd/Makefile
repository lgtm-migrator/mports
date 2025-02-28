# Created by: Andrew Thompson <thompsa@FreeBSD.org>

PORTNAME=	webcamd
PORTVERSION=	5.7.1.1
CATEGORIES=	multimedia
MASTER_SITES=	http://www.selasky.org/hans_petter/distfiles/ \
		http://home.selasky.org/distfiles/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Port of Linux USB webcam and DVB drivers into userspace

LICENSE=	gpl2

BUILD_DEPENDS=	v4l_compat>=1.0.20100321:${PORTSDIR}/multimedia/v4l_compat
LIB_DEPENDS=	libv4l1.so:${PORTSDIR}/multimedia/libv4l

FAKE_OPTS=	trueprefix

USES=		pkgconfig tar:bzip2 uidfix
USE_RC_SUBR=	webcamd
USE_LDCONFIG=	yes

LIBDIR=		${TRUE_PREFIX}/lib

OPTIONS_DEFINE=	CUSE DEBUG HAL VT_CLIENT VT_SERVER DVB INPUT RADIO WEBCAM
OPTIONS_DEFAULT=CUSE DVB HAL INPUT RADIO WEBCAM
CUSE_DESC=	Use CUSE and not CUSE4BSD (MidnightBSD2+ only)
HAL_DESC=	Build with HAL and DBUS support
DEBUG_DESC=	Build with debugging support
VT_CLIENT_DESC=	Build with vTuner client support
VT_SERVER_DESC=	Build with vTuner server support

DVB_DESC=	Build with USB DVB support (DVB-X, analog TV, ...)
INPUT_DESC=	Build with USB input support (tablet, joystick, HID, IR, ...)
RADIO_DESC=	Build with USB radio support
WEBCAM_DESC=	Build with USB webcam support (UVC, gspca, ...)

USERS=		webcamd
GROUPS=		webcamd

.include <bsd.port.pre.mk>

MAKE_ARGS+=	HAVE_MAN="YES"
MAKE_ARGS+=	PTHREAD_LIBS="-lpthread"

.if ${PORT_OPTIONS:MCUSE} || ${OSVERSION} > 200000
MAKE_ARGS+=	HAVE_CUSE="YES"
LIBCUSE=	/usr/lib/libcuse.so
.else
BUILD_DEPENDS+=	cuse4bsd-kmod>=0.1.31:multimedia/cuse4bsd-kmod
LIB_DEPENDS+=	libcuse4bsd.so:multimedia/cuse4bsd-kmod
LIBCUSE=	${LIBDIR}/libcuse4bsd.so
.endif

.if ${PORT_OPTIONS:MDVB}
MAKE_ARGS+=	HAVE_DVB_DRV="YES"
.endif

.if ${PORT_OPTIONS:MINPUT}
MAKE_ARGS+=	HAVE_INPUT_DRV="YES"
.endif

.if ${PORT_OPTIONS:MRADIO}
MAKE_ARGS+=	HAVE_RADIO_DRV="YES"
.endif

.if ${PORT_OPTIONS:MWEBCAM}
MAKE_ARGS+=	HAVE_WEBCAM_DRV="YES"
.endif

.if ${PORT_OPTIONS:MHAL}
MAKE_ARGS+=	HAVE_HAL="YES"
LIBHAL=		${LIBDIR}/libhal.so:${LIBDIR}/libdbus-1.so:
LIB_DEPENDS+=	libhal.so:sysutils/hal
LIB_DEPENDS+=	libdbus-1.so:devel/dbus
.else
LIBHAL=
.endif

.if ${PORT_OPTIONS:MVT_CLIENT}
MAKE_ARGS+=	HAVE_VTUNER_CLIENT="YES"
.endif

.if ${PORT_OPTIONS:MVT_SERVER}
MAKE_ARGS+=	HAVE_VTUNER_SERVER="YES"
.endif

.if ${PORT_OPTIONS:MDEBUG}
MAKE_ARGS+=	HAVE_DEBUG="YES"
.endif

#
# This step is optional
#
do-configure:
	${MAKE} -C${WRKSRC}/tools/linux_make
	${MAKE} ${MAKE_ARGS} configure -C${WRKSRC}

post-patch:
	@(cd ${WRKSRC}/patches && ${SH} ./do_patch.sh)

pre-install:
	${SED} -i .orig \
		-e "s|%%PREFIX%%|${TRUE_PREFIX}|g" \
		-e "s|%%LIBHAL%%|${LIBHAL}|g" \
		-e "s|%%LIBCUSE%%|${LIBCUSE}|g" \
		${WRKDIR}/webcamd

post-install:
	@${MKDIR} ${PREFIX}/etc/devd
	${SED} -e "s|%%PREFIX%%|${TRUE_PREFIX}|g" \
		< ${FILESDIR}/webcamd.conf.in > ${WRKDIR}/webcamd.conf
	${INSTALL_DATA} "${WRKDIR}/webcamd.conf" ${PREFIX}/etc/devd

.include <bsd.port.post.mk>
