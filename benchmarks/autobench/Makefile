PORTNAME=	autobench
PORTVERSION=	2.1.2
CATEGORIES=	benchmarks www
MASTER_SITES=	http://www.xenoclast.org/autobench/downloads/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Automating the process of benchmarking a web server
WWW=		http://www.xenoclast.org/autobench/

LICENSE=	gpl2
LICENSE_FILE=	${WRKSRC}/LICENCE

RUN_DEPENDS=	httperf:benchmarks/httperf \
		gawk:lang/gawk \
		gnuplot:math/gnuplot

USES=		gmake perl5 shebangfix
MAKE_ARGS=	CC="${CC}" CFLAGS="${CFLAGS}" DEBUG_FLAGS= \
		PREFIX=${PREFIX}
SHEBANG_FILES=	autobench_admin autobenchd autobench

post-patch:
.for file in autobench autobench_admin
	@${REINPLACE_CMD} -i '' -e 's|/etc/|${PREFIX}/etc/|' ${WRKSRC}/${file}
.endfor

.include <bsd.port.mk>
