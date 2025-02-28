PORTNAME=	firefox
PORTVERSION=	${VER}
PORTREVISION=	5
CATEGORIES=	www
MASTER_SITES=	https://www.midnightbsd.org/ftp/MidnightBSD/distfiles/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Mozilla Firefox for FreeBSD

LICENSE=	mpl gpl2
LICENSE_COMB=	dual

LIB_DEPENDS+=	libicui18n.so:devel/icu \
		libvpx.so:multimedia/libvpx \
		libevent.so:devel/libevent \
		libstartup-notification-1.so:x11/startup-notification \
		libnspr4.so:devel/nspr \
		libnss3.so:security/nss \
		libicui18n.so.67:devel/icu \
		libharfbuzz.so:print/harfbuzz \
		libgraphite2.so.3:graphics/graphite2 \
		libpng16.so:graphics/png \
		libavcodec.so:multimedia/ffmpeg \
		libffi.so:devel/libffi \
		libpixman-1.so:x11/pixman \
		libwebp.so:graphics/webp \
		libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2 \
		libpci.so:devel/libpci \
		libdbus-1.so:devel/dbus \
		libdbus-glib-1.so:devel/dbus-glib \
		libatk-1.0.so:accessibility/atk

USES=		compiler:c++17-lang cpe gl gettext gmake gnome iconv jpeg localbase perl5 pkgconfig \
		desktop-file-utils tar:xz
CPE_VENDOR=	mozilla
USE_GL=         gl
USE_GNOME=      cairo gdkpixbuf2 gtk20 gtk30
USE_XORG=       x11 xcb xcomposite xdamage xext xfixes xrender xt

ONLY_FOR_ARCHS=	amd64
PLIST=          ${PKGDIR}/pkg-plist${COMPONENT}

NO_BUILD=	yes

.include <bsd.port.pre.mk>

.if ${ARCH} == "amd64"
.if ${OSVERSION} >= 200000
VER=    80
DISTFILES=      firefox-80.0.1,2.txz
COMPONENT=.11
LIB_DEPENDS+=	libaom.so:multimedia/aom \
		libdav1d.so:multimedia/dav1d
.else
VER=    63
DISTFILES=      firefox-63.0_3,1.txz
COMPONENT=.10
MASTER_SITES+=	https://pkg.freebsd.org/FreeBSD:10:amd64/latest/All/
.endif
.endif

do-extract:
	${MKDIR} ${FAKE_DESTDIR}/usr/local
	cd ${FAKE_DESTDIR} && tar -xzf ${DISTDIR}/${DISTFILES}

do-install:
	${NOOP}

.include <bsd.port.post.mk>
