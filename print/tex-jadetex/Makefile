PORTNAME=	jadetex
PORTVERSION=	3.13
PORTREVISION=	3
CATEGORIES=	print
MASTER_SITES=	TEX_CTAN/systems/texlive/${TEXLIVE_YEAR}/
PKGNAMEPREFIX=	tex-
DISTNAME=	texlive-${TEXLIVE_VERSION}-texmf
DIST_SUBDIR=	TeX
EXTRACT_ONLY=

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	TeX backend for Jade, DSSSL processor for SGML/XML documents
WWW=		http://jadetex.sourceforge.net/

LICENSE=	gpl2

USES=		tar:xz
USE_TEX=	texmf pdftex xmltex fmtutil
TEXHASHDIRS=	${TEXMFDISTDIR} ${TEXMFVARDIR}
EXTRACT_AFTER_ARGS=| ${TAR} -xf - -C ${FAKE_DESTDIR}${TRUE_PREFIX}/share \
		--strip-components 1 --no-same-permission --no-same-owner \
		${EXTRACT_FILES:S,^,${DISTNAME}/,}
EXTRACT_FILES= \
	texmf-dist/doc/otherformats/jadetex \
	texmf-dist/source/jadetex/base \
	texmf-dist/tex/jadetex/base
NO_WRKSRC=	yes
NO_BUILD=	yes
TEX_FORMATS=	jadetex

pre-install:
	${MKDIR} ${FAKE_DESTDIR}${TRUE_PREFIX}/share
	${CAT} ${DISTDIR}/${DIST_SUBDIR}/${DISTNAME}${EXTRACT_SUFX} \
	    ${EXTRACT_AFTER_ARGS}

do-install: do-texhash do-fmtutil
	${REINPLACE_CMD} -e 's|${FAKE_DESTDIR}||g' \
		${PREFIX}/share/texmf-var/web2c/pdftex/jadetex.log \
		${PREFIX}/share/texmf-var/web2c/pdftex/pdfjadetex.log

.include <bsd.port.mk>
