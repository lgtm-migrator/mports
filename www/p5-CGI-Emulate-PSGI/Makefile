PORTNAME=	CGI-Emulate-PSGI
PORTVERSION=	0.20
PORTREVISION=	1
CATEGORIES=	www perl5
MASTER_SITES=	CPAN
MASTER_SITE_SUBDIR=	CPAN:MIYAGAWA
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Perl extension of PSGI adapter for CGI

LICENSE=	artistic gpl
LICENSE_COMB=	dual

BUILD_DEPENDS=	${RUN_DEPENDS}
RUN_DEPENDS=	\
	p5-libwww>0:www/p5-libwww

USES=		perl5
USE_PERL5=	configure
NO_ARCH=	YES

# dependency issues
NO_TEST=	yes

.include <bsd.port.mk>
