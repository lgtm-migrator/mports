# Created by: Koop Mast <kwm@FreeBSD.org>

PORTNAME=	ocl-icd
DISTVERSIONPREFIX=	v
PORTVERSION=	2.3.1
CATEGORIES=	devel

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	OpenCL Installable Client Driver

LICENSE=	bsd2
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	opencl>=3.0:devel/opencl

USES=		autoreconf gmake libtool localbase:ldflags pathfix

USE_GITHUB=	yes
GH_ACCOUNT=	OCL-dev
USE_RUBY=	yes
RUBY_NO_RUN_DEPENDS=	yes
USE_LDCONFIG=	yes
GNU_CONFIGURE=	yes
CPPFLAGS+=	-DCL_TARGET_OPENCL_VERSION=300

INSTALL_TARGET=	install-strip

CONFIGURE_ARGS+=--disable-official-khronos-headers \
		--enable-custom-vendordir \
		--enable-pthread-once
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd11.4

OPTIONS_DEFINE=	DOCS MANPAGES
OPTIONS_DEFAULT=MANPAGES
OPTIONS_SUB=	yes

MANPAGES_BUILD_DEPENDS=	xmlto:textproc/xmlto \
			asciidoc:textproc/asciidoc

USE_GCC=	yes

post-patch:
	@${REINPLACE_CMD} -e 's|/etc/|${LOCALBASE}/etc/|g' \
		${WRKSRC}/doc/libOpenCL.7.txt.in

.include <bsd.port.mk>
