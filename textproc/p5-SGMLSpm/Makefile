# New ports collection makefile for:	SGMLSpm
# Date created:		4 May 2004
# Whom:			Brian Candler <B.Candler@pobox.com>
#

#

PORTNAME=	SGMLSpm
PORTVERSION=	1.03
CATEGORIES=	textproc perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN}
MASTER_SITE_SUBDIR=	SGMLS
PKGNAMEPREFIX=	p5-
DISTNAME=	${PORTNAME}-${PORTVERSION}ii

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Perl module for postprocessing the output from sgmls and nsgmls

LICENSE=	gpl2

USE_PERL5=	run
NO_BUILD=	yes
WRKSRC=		${WRKDIR}/${PORTNAME}


FAKE_MAKEARGS=	BINDIR=${FAKE_DESTDIR}${PREFIX}/bin PERL5DIR=${FAKE_DESTDIR}${SITE_PERL} 
FAKE_MAKEARGS+= SPECDIR=${FAKE_DESTDIR}${EXAMPLESDIR} HTMLDIR=${FAKE_DESTDIR}${DOCSDIR}

pre-install:
	${MKDIR} ${DOCSDIR} ${EXAMPLESDIR} ${FAKE_DESTDIR}${SITE_PERL}


.ifndef(NOPORTDOCS)
PORTDOCS=	*
INSTALL_TARGET= install docs install_html 
.endif

.include <bsd.port.mk>
