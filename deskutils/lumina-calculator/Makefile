PORTNAME=	lumina-calculator
DISTVERSION=	1.6.0
PORTREVISION=	1
CATEGORIES=	deskutils

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Scientific calculator from the Lumina Desktop

LICENSE=	bsd3

USES=		compiler:c++11-lang gl qmake qt:5 xorg
USE_GL=		gl
USE_XORG=	x11
USE_QT=		buildtools_build core gui svg widgets
USE_GITHUB=	yes
GH_ACCOUNT=	lumina-desktop
GH_TAGNAME=	ccb792fc713aa7163fffd37fc20c83ffe9ca7523

OPTIONS_DEFINE=		NLS
OPTIONS_SUB=		yes

NLS_USE=	qt=linguist_build
NLS_QMAKE_ON=	CONFIG+=WITH_I18N

CONFLICTS_INSTALL=	lumina-1.2.*

WRKSRC_SUBDIR=	src-qt5

.include <bsd.port.mk>
