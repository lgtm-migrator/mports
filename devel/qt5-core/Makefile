PORTNAME=	core
DISTVERSION=	${QT5_VERSION}
CATEGORIES=	devel
PKGNAMEPREFIX=	qt5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Qt core non-graphical module

LIB_DEPENDS=	libdouble-conversion.so:devel/double-conversion \
		libicui18n.so:devel/icu \
		libpcre2-posix.so:devel/pcre2 \
		libzstd.so:archivers/zstd

USES=		compiler:c++11-lang gnome qmake:no_env qt-dist:5,base
USE_GNOME=	glib20
USE_QT=		qmake_build buildtools_build
HAS_CONFIGURE=	yes
# Disable (almost) everything to install minimal qconfig.h.
# -no-feature-* adds QT_NO_* (for features which have no switch or
# that need to be detected).
CONFIGURE_ARGS=	-no-accessibility -no-gif -no-libpng -no-libjpeg \
		-no-openssl -no-gui -no-widgets -no-cups \
		-no-iconv -no-dbus -no-opengl \
		-no-egl -no-evdev \
		-no-fontconfig -no-freetype -no-gtk -no-harfbuzz \
		-no-libudev -no-xcb -no-xcb-xlib \
		-no-xkbcommon -no-libinput

USE_LDCONFIG=	${PREFIX}/${QT_LIBDIR_REL}

BUILD_WRKSRC=	${WRKSRC}/src/corelib
INSTALL_WRKSRC=	${BUILD_WRKSRC}

QT_BINARIES=	yes
QT_DEFINES=	GLIB
QT_CONFIG=	glib icu

MORE_WRKSRCS=	src/tools/bootstrap src/corelib src/tools/qlalr

.include <bsd.port.pre.mk>

.if !exists(/etc/rc.d/os-release) && (${OSVERSION} < 201001)
RUN_DEPENDS+=	etc_os-release>0:sysutils/etc_os-release
.endif
post-patch:
	${REINPLACE_CMD}  -e '/readEtcFile/s|/etc/os-release|${LOCALBASE}/etc/os-release|g' \
		${WRKSRC}/src/corelib/global/qglobal.cpp

post-configure:
.for d in ${MORE_WRKSRCS}
	${MKDIR} ${WRKSRC}/${d}
	cd ${WRKSRC}/${d} && ${SETENV} ${QMAKE_ENV} ${FAKE_MAKEENV} ${_QMAKE} ${QMAKE_ARGS} ${FAKE_MAKEARGS} ${WRKSRC}/${d}
.endfor

pre-build:
.for d in ${MORE_WRKSRCS}
	${MKDIR} ${WRKSRC}/${d}
	cd ${WRKSRC}/${d} && \
		${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${FAKE_MAKEFLAGS} ${MAKEFILE} \
		${_MAKE_JOBS} ${MAKE_ARGS} ${FAKE_MAKEARGS} ${ALL_TARGET}
.endfor

post-install:
# Allow qconfig.h to be customized by single ports.
	${AWK} 'BEGIN{print "#include <QtCore/qconfig-modules.h>"}{print}' \
		${PREFIX}/${QT_INCDIR_REL}/QtCore/qconfig.h > ${WRKDIR}/qconfig.h
# Manually install qlalr
	cd ${WRKSRC}/src/tools/qlalr && \
		${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${FAKE_MAKEFLAGS} ${MAKEFILE} \
		${MAKE_ARGS} ${FAKE_MAKEARGS} ${INSTALL_TARGET}
# Cleanup qconfig.h and remove stray '#define QT_NO_FOO'
	${REINPLACE_CMD} "/#define QT_NO_/d" ${WRKDIR}/qconfig.h
	${MV} ${WRKDIR}/qconfig.h ${PREFIX}/${QT_INCDIR_REL}/QtCore/qconfig.h
	${REINPLACE_CMD} 's|/../../../../|/../../../|g' \
		${PREFIX}/lib/cmake/Qt5*/Qt5*Config.cmake


.include <bsd.port.post.mk>
