

PORTNAME=	ntfs
PORTVERSION=	2015.3.14
PORTREVISION=	3
CATEGORIES=	sysutils
MASTER_SITES=	http://tuxera.com/opensource/
PKGNAMEPREFIX=	fusefs-
DISTNAME=	${PORTNAME}-3g_ntfsprogs-${PORTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Mount NTFS partitions (read/write) and disk images

LICENSE=	gpl2
LICENSE_FILE=	${WRKSRC}/COPYING

CONFLICTS_BUILD=	bonobo-1.*
CONFLICTS_INSTALL=	ntfsprogs-*
USES=		fuse pkgconfig iconv libtool tar:tgz
USE_LDCONFIG=	yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--exec-prefix=${PREFIX} --disable-mount-helper \
		--disable-mtab --with-fuse=external --disable-ldconfig
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd9.1
CPPFLAGS+=	-I${WRKSRC}/include/ntfs-3g/ -I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

OPTIONS_DEFINE=	LOCK UBLIO DOCS
OPTIONS_DEFAULT=LOCK UBLIO
LOCK_DESC=	Lock the device when mounting (avoids access)
UBLIO_DESC=	Enable user space cache for improved speed

SUB_FILES=	pkg-message
DOCSDIR=	${PREFIX}/share/doc/ntfs-3g

.include <bsd.port.pre.mk>

.if ${PORT_OPTIONS:MLOCK}
CFLAGS+=	-DUSE_LOCK
.endif

.if ${PORT_OPTIONS:MUBLIO}
EXTRA_PATCHES+=	${FILESDIR}/extra-patch-ublio
LIB_DEPENDS+=	libublio.so:${PORTSDIR}/devel/libublio
CFLAGS+=	-DUSE_UBLIO
.endif

post-patch:
	@${REINPLACE_CMD} -e 's|ENODATA|ENOATTR|' \
		${WRKSRC}/libntfs-3g/object_id.c \
		${WRKSRC}/libntfs-3g/reparse.c \
		${WRKSRC}/libntfs-3g/security.c
	@${REINPLACE_CMD} -e 's|\($$(AM_CFLAGS)\) \(-I$$(top_srcdir)/include/ntfs-3g\)|\2 \1|; \
		/install-exec-hook:/,/^$$/ s|^@.*||' ${WRKSRC}/libntfs-3g/Makefile.in

post-install:
	${INSTALL_DATA} ${FILESDIR}/README.FreeBSD ${STAGEDIR}${DOCSDIR}/
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libntfs-3g.so

.include <bsd.port.post.mk>
