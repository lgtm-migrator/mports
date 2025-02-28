PORTNAME=	network
DISTVERSION=	${QT5_VERSION}
PORTREVISION=	2
CATEGORIES=	net
PKGNAMEPREFIX=	qt5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Qt network module

RUN_DEPENDS=	${LOCALBASE}/share/certs/ca-root-nss.crt:security/ca_root_nss

USES=		compiler:c++11-lang qmake:no_env qt-dist:5,base ssl
USE_QT=		core buildtools_build
HAS_CONFIGURE=	yes
CONFIGURE_ARGS=	-no-gui -no-xcb

BUILD_WRKSRC=	${WRKSRC}/src/${PORTNAME}
INSTALL_WRKSRC=	${BUILD_WRKSRC}

QT_DEFINES=	OPENSSL SSL
QT_CONFIG=	openssl

.include <bsd.port.pre.mk>

.if ${SSL_DEFAULT} == "base"
BROKEN=               Qt5 requires Openssl 1.1.1, add DEFAULT_VERSIONS+=ssl=[openssl|libressl*] to /etc/make.conf
.endif
# LibreSSL does not currently support BIO_ADDR in DTLSv1_listen()
.if ${SSL_DEFAULT:Mlibressl*}
CONFIGURE_ARGS+=	-no-feature-dtls
.endif

post-patch:
	@${REINPLACE_CMD} -e 's|/usr/local|${LOCALBASE}|g' \
		${BUILD_WRKSRC}/ssl/qsslsocket_openssl.cpp
	@${REINPLACE_CMD} -e 's|%%OPENSSLLIB%%|${OPENSSLLIB}|g' \
		${BUILD_WRKSRC}/ssl/qsslsocket_openssl_symbols.cpp

post-configure:
.for d in src/network src/plugins/bearer/generic
	${MKDIR} ${WRKSRC}/${d}
	cd ${WRKSRC}/${d} && ${SETENV} ${QMAKE_ENV} ${_QMAKE} ${QMAKE_ARGS} ${WRKSRC}/${d}
.endfor

post-build:
	@cd ${WRKSRC}/src/plugins/bearer/generic && \
		${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${MAKEFILE} \
		${_MAKE_JOBS} ${MAKE_ARGS} ${ALL_TARGET}

post-install:
	@cd ${WRKSRC}/src/plugins/bearer/generic && \
		${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${FAKE_MAKEFLAGS} ${MAKEFILE} \
		${MAKE_ARGS} ${FAKE_MAKEARGS} ${INSTALL_TARGET}
	${REINPLACE_CMD} 's|/../../../../|/../../../|g' \
		${PREFIX}/lib/cmake/Qt5*/Qt5*Config.cmake


.include <bsd.port.post.mk>
