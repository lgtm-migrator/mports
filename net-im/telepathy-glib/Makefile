

PORTNAME=	telepathy-glib
PORTVERSION=	0.24.1
PORTREVISION=	1
CATEGORIES=	net-im
MASTER_SITES=	http://telepathy.freedesktop.org/releases/${PORTNAME}/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	GLib utility library for the Telepathy framework

LICENSE=	lgpl2.1
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	vapigen:lang/vala
LIB_DEPENDS=	libdbus-glib-1.so:devel/dbus-glib
RUN_DEPENDS=	vapigen:lang/vala

PORTSCOUT=	limitw:1,even

USES=		gmake gnome libtool pathfix pkgconfig python:build
USE_GNOME=	glib20 introspection:build libxslt:build
USE_LDCONFIG=	yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-vala-bindings
INSTALL_TARGET=	install-strip

.include <bsd.port.mk>
