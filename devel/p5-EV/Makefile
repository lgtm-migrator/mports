PORTNAME=	EV
PORTVERSION=	4.33
PORTEPOCH=	1
CATEGORIES=	devel perl5
MASTER_SITES=	CPAN
MASTER_SITE_SUBDIR=	CPAN:MLEHMANN
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Perl interface to libev, a high performance full-featured event loop
WWW=		https://metacpan.org/release/EV

LICENSE=	artistic gpl
LICENSE_COMB=	dual

RUN_DEPENDS=	p5-common-sense>=0:devel/p5-common-sense
BUILD_DEPENDS=	p5-common-sense>=0:devel/p5-common-sense \
		p5-Canary-Stability>=0:devel/p5-Canary-Stability

USES=		perl5
USE_PERL5=	configure
CONFIGURE_ENV=	PERL_MM_USE_DEFAULT="YES"

post-install:
	${STRIP_CMD} ${PREFIX}/${SITE_ARCH_REL}/auto/EV/EV.so

.include <bsd.port.mk>
