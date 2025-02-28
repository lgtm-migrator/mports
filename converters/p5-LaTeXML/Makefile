# Created by: Carlos J. Puga Medina <cpm@fbsd.es>

PORTNAME=	LaTeXML
PORTVERSION=	0.8.6
CATEGORIES=	converters perl5
MASTER_SITES=	CPAN \
		http://dlmf.nist.gov/LaTeXML/releases/
MASTER_SITE_SUBDIR=	CPAN:BRMILLER
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	LaTeX to XML/HTML/MathML converter in Perl

LICENSE=	publicdom CC0-1.0
LICENSE_COMB=	dual
LICENSE_FILE_CC0-1.0=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${RUN_DEPENDS}
RUN_DEPENDS=	p5-Archive-Zip>=0:archivers/p5-Archive-Zip \
		p5-JSON-XS>=0:converters/p5-JSON-XS \
		p5-Text-Unidecode>=0:converters/p5-Text-Unidecode \
		p5-IO-String>=0:devel/p5-IO-String \
		p5-Parse-RecDescent>=0:devel/p5-Parse-RecDescent \
		p5-Image-Size>=0:graphics/p5-Image-Size \
		p5-URI>=0:net/p5-URI \
		p5-File-Which>=0:sysutils/p5-File-Which \
		p5-XML-LibXML>=1.62:textproc/p5-XML-LibXML \
		p5-XML-LibXSLT>=1.58:textproc/p5-XML-LibXSLT \
		${P5_POD_PARSER} \
		p5-libwww>=0:www/p5-libwww

USES=		perl5
USE_PERL5=	configure
USE_TEX=	kpathsea
NO_ARCH=	yes
NO_BUILD=	yes
NO_TEST=	yes

PORTDOCS=		Changes README.pod manual.pdf

OPTIONS_DEFINE=	DOCS

post-install:
	${FIND} ${PREFIX} -name .packlist | \
		${XARGS} ${REINPLACE_CMD} -e 's|^${FAKE_DESTDIR}||'
	${RM} ${PREFIX}/share/texmf-local/tex/latex/latexml/.packlist.bak

post-install-DOCS-on:
	@${MKDIR} ${FAKE_DESTDIR}${DOCSDIR}
	cd ${WRKSRC} && ${INSTALL_DATA} ${PORTDOCS} ${FAKE_DESTDIR}${DOCSDIR}

.include <bsd.port.mk>
