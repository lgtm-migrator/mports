PORTNAME=	basu
DISTVERSIONPREFIX=	v
DISTVERSION=	0.2.0
PORTREVISION=	1
CATEGORIES=	devel

PATCH_SITES=	https://github.com/${GH_ACCOUNT}/${GH_PROJECT}/commit/
PATCHFILES+=	928a746f7ebd.patch:-p1 # https://github.com/emersion/basu/pull/35
PATCHFILES+=	4277dfe8077c.patch:-p1 # https://github.com/emersion/basu/pull/35
PATCHFILES+=	f12a4efd8cb7.patch:-p1 # https://github.com/emersion/basu/pull/40

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	sd-bus library, extracted from systemd

LICENSE=	lgpl2.1
LICENSE_FILE=	${WRKSRC}/LICENSE.LGPL2.1

USES=		compiler:c11 gperf meson python:build shebangfix
USE_GITHUB=	yes
USE_LDCONFIG=	yes
GH_ACCOUNT=	emersion
SHEBANG_FILES=	src/basic/generate-gperfs.py

USE_GCC=	10+
NO_TEST=	yes

.if exists(/usr/bin/ld.lld) && ${/usr/bin/ld:L:tA} != /usr/bin/ld.lld
# bus-error.c:(.text.bus_error_name_to_errno+0x9a): undefined reference to '__start_BUS_ERROR_MAP'
LDFLAGS+=	-fuse-ld=lld
.endif

.include <bsd.port.mk>
