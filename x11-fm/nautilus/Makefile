PORTNAME=	nautilus
PORTVERSION=	3.28.1
PORTREVISION=	2
CATEGORIES=	x11-fm gnome
MASTER_SITES=	GNOME
DIST_SUBDIR=	gnome

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	File manager for the GNOME desktop

LICENSE=	gpl3
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libgnome-autoar-0.so:archivers/gnome-autoar \
		libgexiv2.so:graphics/gexiv2 \
		libtracker-sparql-2.0.so:sysutils/tracker

PORTSCOUT=	limitw:1,even

USES=		compiler:c11 cpe desktop-file-utils gettext gnome \
		localbase meson pkgconfig python:3.4+,build tar:xz
USE_GNOME=	cairo gdkpixbuf2 gnomedesktop3
INSTALLS_ICONS=	yes
USE_LDCONFIG=	yes
USE_XORG=	x11
MESON_ARGS=	-Dpackagekit=false \
		-Dselinux=false
CPE_VENDOR=	gnome
BINARY_ALIAS=	python3=${PYTHON_VERSION}

GLIB_SCHEMAS=	org.gnome.nautilus.gschema.xml

NO_TEST=	yes

.include <bsd.port.mk>
