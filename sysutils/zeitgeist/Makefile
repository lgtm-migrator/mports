PORTNAME=	zeitgeist
PORTVERSION=	1.0.2
CATEGORIES=	sysutils
MASTER_SITES=	https://launchpad.net/${PORTNAME}/${PORTVERSION:C/^([0-9]+\.[0-9]+).*/\1/}/${PORTVERSION}/+download/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Event logging framework

LICENSE=	gpl2 lgpl2.1
LICENSE_COMB=	multi

BUILD_DEPENDS=	valac:lang/vala \
		dee-tool:devel/dee \
		rapper:textproc/raptor2 \
		${PYTHON_PKGNAMEPREFIX}rdflib>=4.1.1:textproc/py-rdflib@${PY_FLAVOR}
RUN_DEPENDS=	${PYTHON_SITELIBDIR}/xdg/__init__.py:devel/py-xdg@${PY_FLAVOR} \
		${PYTHON_SITELIBDIR}/dbus/__init__.py:devel/py-dbus@${PY_FLAVOR}

USES=		gettext gmake gnome libtool pathfix pkgconfig python sqlite tar:xz
USE_GNOME=	intlhack glib20 introspection:build
USE_LDCONFIG=	yes
USE_PYTHON=	py3kplist
USE_SQLITE=	3
GNU_CONFIGURE=	yes
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib
INSTALL_TARGET=	install-strip

CONFIGURE_ARGS=	--disable-fts --disable-telepathy \
		--disable-downloads-monitor

OPTIONS_SUB=	yes
OPTIONS_DEFINE=	DATAHUB
OPTIONS_DEFAULT=DATAHUB
DATAHUB_LIB_DEPENDS=	libjson-glib-1.0.so:devel/json-glib
DATAHUB_USE=	gnome=gtk30
DATAHUB_CONFIGURE_ENABLE=	datahub
DATAHUB_DESC=	Passive loggers for Zeitgeist

post-patch:
	@${REINPLACE_CMD} -e 's|python -|${PYTHON_CMD} -|g' \
		${WRKSRC}/configure

.include <bsd.port.mk>
