# Created by: Mathieu Arnold <m@absolight.net>

PORTNAME=	DateTime-Format-Mail
PORTVERSION=	0.403
CATEGORIES=	devel perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Convert between DateTime and RFC2822/822 formats

LICENSE=	artistic gpl
LICENSE_COMB=	dual
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${RUN_DEPENDS}
RUN_DEPENDS=	p5-Params-Validate>=0:devel/p5-Params-Validate \
		p5-DateTime>=0:devel/p5-DateTime

PORTSCOUT=	skipv:0.2901,0.3001

NO_ARCH=	yes
USES=		perl5
USE_PERL5=	configure

.include <bsd.port.mk>
