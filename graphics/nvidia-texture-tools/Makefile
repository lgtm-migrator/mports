# Created by: Dmitry Marakasov <amdmi3@FreeBSD.org>

PORTNAME=	nvidia-texture-tools
PORTVERSION=	2.0.8.1 # needed to not bump PORTEPOCH; remove on next update
PORTREVISION=	2
CATEGORIES=	graphics

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Texture Tools with support for DirectX 10 texture formats

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/NVIDIA_Texture_Tools_LICENSE.txt

# see src/nvcore/nvcore.h
ONLY_FOR_ARCHS=		amd64 i386 powerpc powerpc64

LIB_DEPENDS=	libpng.so:graphics/png \
		libtiff.so:graphics/tiff \
		libOpenEXR.so:graphics/openexr

USE_GITHUB=	yes
GH_ACCOUNT=	castano
GH_TAGNAME=	${PORTVERSION:R}

USES=		alias cmake compiler:c++11-lang jpeg
CMAKE_ARGS=	-DNVTT_SHARED=TRUE

CFLAGS+=	-fPIC
CXXFLAGS+=	-fPIC

PORTDOCS=	NVIDIA_Texture_Tools_README.txt ChangeLog

OPTIONS_DEFINE=	DOCS
OPTIONS_SUB=	yes

post-install-DOCS-on:
	@${MKDIR} ${FAKE_DESTDIR}${DOCSDIR}
.for f in ${PORTDOCS}
	${INSTALL_DATA} ${WRKSRC}/${f} ${FAKE_DESTDIR}${DOCSDIR}
.endfor

.include <bsd.port.mk>
