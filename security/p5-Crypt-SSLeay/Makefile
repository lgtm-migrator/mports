

PORTNAME=	Crypt-SSLeay
PORTVERSION=	0.72
PORTREVISION=	1
CATEGORIES=	security perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Perl5 interface to allow p5-libwww LWP to make https connections

LICENSE=	artistic2

BUILD_DEPENDS=	p5-LWP-Protocol-https>=6.02:${PORTSDIR}/www/p5-LWP-Protocol-https \
		p5-Path-Class>=0.26:${PORTSDIR}/devel/p5-Path-Class \
		p5-Try-Tiny>=0.19:${PORTSDIR}/lang/p5-Try-Tiny
RUN_DEPENDS=	p5-LWP-Protocol-https>=6.02:${PORTSDIR}/www/p5-LWP-Protocol-https

USES=		perl5 ssl
PERL_CONFIGURE=	yes
USE_PERL5=	configure
CONFIGURE_ARGS=	--no-live-tests

.include <bsd.port.mk>
