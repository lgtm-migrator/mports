# Created by: Anton Berezin <tobez@tobez.org>

PORTNAME=	Cache-Cache
PORTVERSION=	1.08
CATEGORIES=	devel perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Perl Cache interface

LICENSE=	artistic gpl
LICENSE_COMB=	dual

BUILD_DEPENDS=	${RUN_DEPENDS}
RUN_DEPENDS=	p5-Cache>=0:devel/p5-Cache \
		p5-Digest-SHA1>=2.02:security/p5-Digest-SHA1 \
		p5-Error>=0.15:lang/p5-Error \
		p5-IPC-ShareLite>=0.09:devel/p5-IPC-ShareLite

USES=		perl5
USE_PERL5=	configure

.include <bsd.port.mk>
