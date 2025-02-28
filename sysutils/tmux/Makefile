# Created by: Wen Heping <wenheping@gmail.com>

PORTNAME=	tmux
PORTVERSION=	3.2a
CATEGORIES=	sysutils
MASTER_SITES=	https://github.com/tmux/tmux/releases/download/${PORTVERSION}/
DISTFILES=	${DISTNAME}${EXTRACT_SUFX}

MAINTAINER=	kraileth@elderlinux.org
COMMENT=	Terminal Multiplexer

LICENSE=			iscl gpl2
LICENSE_COMB=			multi
LICENSE_FILE_iscl=		${WRKSRC}/COPYING
LICENSE_FILE_gpl2=		${WRKSRC_bash}/COPYING
LICENSE_DISTFILES_iscl=		${DISTNAME}${EXTRACT_SUFX}
LICENSE_DISTFILES_gpl2=		${DISTFILE_bash}

USES=		ncurses pkgconfig

USE_GITHUB=	nodefault
GH_TUPLE=	imomaliev:tmux-bash-completion:f5d5323:bash

GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-utempter \
		--sysconfdir=${PREFIX}/etc

PLIST_FILES=	bin/tmux \
		etc/bash_completion.d/tmux \
		man/man1/tmux.1.gz

PORTDOCS=	CHANGES README
PORTEXAMPLES=	*

OPTIONS_DEFINE=	DOCS EXAMPLES LIBEVENT_STATIC UTF8PROC

LIBEVENT_STATIC_DESC=	Build with static libevent
UTF8PROC_DESC=		Build with utf8proc support

LIBEVENT_STATIC_BUILD_DEPENDS=		${LOCALBASE}/lib/libevent.a:devel/libevent
LIBEVENT_STATIC_LIB_DEPENDS_OFF=	libevent.so:devel/libevent
LIBEVENT_STATIC_VARS=			LESTATIC=${LOCALBASE}/lib/libevent.a

UTF8PROC_LIB_DEPENDS=		libutf8proc.so:textproc/utf8proc
UTF8PROC_CONFIGURE_ENABLE=	utf8proc

post-patch:
	@${REINPLACE_CMD} -e 's|/etc/tmux.conf|${PREFIX}/etc/tmux.conf|g' ${WRKSRC}/CHANGES \
		${WRKSRC}/tmux.h

post-configure-LIBEVENT_STATIC-on:
	${REINPLACE_CMD} -e '/LIBS/s|-levent[^[:blank:]]*|${LESTATIC}|' \
		${WRKSRC}/${MAKEFILE}

post-install:
	@${MKDIR} ${PREFIX}/etc/bash_completion.d
	${INSTALL_DATA} ${WRKSRC_bash}/completions/tmux ${PREFIX}/etc/bash_completion.d/tmux

post-install-DOCS-on:
	@${MKDIR} ${FAKE_DESTDIR}${DOCSDIR}
	(cd ${WRKSRC} && ${INSTALL_DATA} ${PORTDOCS} ${FAKE_DESTDIR}${DOCSDIR})

post-install-EXAMPLES-on:
	@${MKDIR} ${FAKE_DESTDIR}${EXAMPLESDIR}
	${INSTALL_DATA} ${WRKSRC}/example* ${FAKE_DESTDIR}${EXAMPLESDIR}

.include <bsd.port.mk>
