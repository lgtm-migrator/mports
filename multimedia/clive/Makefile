# New ports collection makefile for:	clive
#


PORTNAME=	clive
PORTVERSION=	2.3.3
CATEGORIES=	multimedia
MASTER_SITES=	SF/${PORTNAME}/${PORTVERSION:R}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Command line video extraction tool for YouTube and others

LICENSE=	gpl3

TEST_DEPENDS=	p5-Test-Pod>=1:${PORTSDIR}/devel/p5-Test-Pod
BUILD_DEPENDS=	p5-Getopt-ArgvFile>=1.11:${PORTSDIR}/devel/p5-Getopt-ArgvFile \
		p5-JSON-XS>=2.30:${PORTSDIR}/converters/p5-JSON-XS
RUN_DEPENDS=	p5-Getopt-ArgvFile>=1.11:${PORTSDIR}/devel/p5-Getopt-ArgvFile \
		p5-JSON-XS>=2.30:${PORTSDIR}/converters/p5-JSON-XS \
		quvi>=0.2.16.1:${PORTSDIR}/multimedia/quvi

CONFLICTS=	py*-clive-[0-1]* ljclive-[0-9]*

USES=		perl5
USE_PERL5=	configure
PERL_CONFIGURE=	yes

PLIST_FILES=	bin/clive \
		man/man1/clive.1.gz

.include <bsd.port.mk>
