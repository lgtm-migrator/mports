PORTNAME=	npm
PORTVERSION=	8.5.2
CATEGORIES=	www
MASTER_SITES=	FREEBSD_LOCAL/sunpoet

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Node package manager

LICENSE=	apache2
LICENSE_FILE=	${WRKSRC}/lib/node_modules/npm/LICENSE

RUN_DEPENDS=	gmake:devel/gmake

USES?=		nodejs:run
USES+=		cpe python:3.7+ shebangfix tar:xz

NO_ARCH=	yes
NO_BUILD=	yes
REINPLACE_ARGS=	-i ''

CONFLICTS_INSTALL?=	npm-node14 npm-node16 npm-node17

CPE_VENDOR=	npmjs

SHEBANG_GLOB=	*.py

post-patch:
	@${REINPLACE_CMD} -e 's|/usr/local|${PREFIX}|' ${WRKSRC}/etc/man.d/npm.conf
	@${REINPLACE_CMD} -e 's|/usr/local|${LOCALBASE}|' ${WRKSRC}/lib/node_modules/npm/node_modules/node-gyp/gyp/gyp
	@${REINPLACE_CMD} -e 's|exec python |exec ${PYTHON_CMD} |' ${WRKSRC}/lib/node_modules/npm/node_modules/node-gyp/gyp/gyp
	@${FIND} ${WRKSRC}/ -name '*.sh' -exec ${REINPLACE_CMD} -e '1 s|/usr/local|${LOCALBASE}|' {} +

do-install:
	cd ${WRKSRC}/ && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/
	${ECHO_CMD} 'python=${PYTHON_CMD}' > ${STAGEDIR}${PREFIX}/etc/npmrc
	${PYTHON_CMD} -O -m compileall -d ${PREFIX}/lib/node_modules/npm/node_modules/node-gyp/gyp/pylib/gyp -f ${PREFIX}/lib/node_modules/npm/node_modules/node-gyp/gyp/pylib/gyp

.include <bsd.port.mk>
