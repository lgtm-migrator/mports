# Created by: Masaki TAGAWA <masaki@club.kyutech.ac.jp>

PORTNAME=	sourcecodepro
PORTVERSION=	2.030
PORTREVISION=	1
DISTVERSIONSUFFIX=	R-ro/1.050R-it
CATEGORIES=	x11-fonts
PKGNAMESUFFIX=	-ttf

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Set of fonts by Adobe designed for coders

LICENSE=	OFL11
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

PORTSCOUT=	skipv:variable-fonts

USES=		fonts

NO_ARCH=	yes
NO_BUILD=	yes

FONTNAME=	SourceCodePro
SUB_FILES=	pkg-message

GH_ACCOUNT=	adobe-fonts
GH_PROJECT=	source-code-pro
USE_GITHUB=	yes

do-install:
	${MKDIR} ${STAGEDIR}${FONTSDIR}/
	${INSTALL_DATA} ${WRKSRC}/TTF/*.ttf ${STAGEDIR}${FONTSDIR}/

.include <bsd.port.mk>
