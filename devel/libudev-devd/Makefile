PORTNAME=	libudev-devd
DISTVERSIONPREFIX=	v
DISTVERSION=	0.5.0
CATEGORIES=	devel

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	libudev-compatible interface for devd

LICENSE=	bsd2

BUILD_DEPENDS=	${LOCALBASE}/include/linux/input.h:devel/evdev-proto

USE_GITHUB=	yes
GH_ACCOUNT=	wulf7

USES=		compiler:c11 localbase meson
USE_LDCONFIG=	yes

CFLAGS+=	-Wno-error

PLIST_FILES=	include/libudev.h \
		lib/libudev.so \
		lib/libudev.so.0 \
		lib/libudev.so.0.0.0 \
		libdata/pkgconfig/libudev.pc

OPTIONS_DEFINE=	GPL

GPL_DESC=	Enable GPL-licensed code
GPL_MESON_TRUE=	enable-gpl
GPL_VARS=	LICENSE+=lgpl2.1 LICENSE_COMB=multi

.include <bsd.port.mk>
