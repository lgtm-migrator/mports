# Created by: Akinori MUSHA aka knu <knu@idaemons.org>

PORTNAME=	ruby
PORTVERSION=	${RUBY_PORTVERSION}
PORTREVISION=	${RUBY_PORTREVISION}
PORTEPOCH=	${RUBY_PORTEPOCH}
CATEGORIES=	lang ruby
MASTER_SITES=	RUBY/${MASTER_SITE_SUBDIR_RUBY}
DISTNAME=	${RUBY_DISTNAME}
DIST_SUBDIR=	ruby

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Object-oriented interpreted scripting language

LICENSE=	bsd2 ruby
LICENSE_COMB=	dual
LICENSE_FILE_bsd2=${WRKSRC}/BSDL
LICENSE_FILE_ruby=	${WRKSRC}/COPYING

DEPRECATED=	Please migrate to newer versions. Ruby 2.7 will reach its EoL on April 12, 2023
EXPIRATION_DATE=	2023-04-12

# Using LIB_DEPENDS finds the libffi from gcc which causes problems
BUILD_DEPENDS=	libffi>=0:devel/libffi
LIB_DEPENDS=	libyaml.so:textproc/libyaml
RUN_DEPENDS=	libffi>=0:devel/libffi

FAKE_OPTS=	trueprefix

USES=		autoreconf compiler cpe ssl tar:xz

CONFIGURE_ARGS=	${RUBY_CONFIGURE_ARGS} \
		--disable-rpath \
		--enable-pthread \
		--enable-shared \
		--enable-install-static-library \
		--with-ruby-version=minor \
                --with-bindir="${LOCALBASE}/bin" \
                --with-sitedir="${LOCALBASE}/lib/ruby/site_ruby" \
                --with-vendordir="${LOCALBASE}/lib/ruby/vendor_ruby" \
                --with-rubyhdrdir="${LOCALBASE}/include/ruby-2.7/" \
                --with-rubylibprefix="${LOCALBASE}/lib/ruby" \
                --docdir="${LOCALBASE}/share/doc/ruby26" \
                --mandir="${LOCALBASE}/man" \
               --with-destdir=${FAKE_DESTDIR}
CONFIGURE_ENV=	debugflags=
CPPFLAGS+=	-I${LOCALBASE}/include
GNU_CONFIGURE=	yes
# Keep this, else ruby will fail to load libraries dependent of libpthread.
LIBS+=		-lpthread -L${LOCALBASE}/lib
USE_LDCONFIG=	yes
WRKSRC=		${RUBY_WRKSRC}
MAKE_JOBS_UNSAFE=	yes

RUBY_VER=		2.7
USE_RUBY=		yes
RUBY_NO_BUILD_DEPENDS=	yes
RUBY_NO_RUN_DEPENDS=	yes

OSMAJOR=        ${OSREL:C/\..*//}

OPTIONS_DEFINE=		CAPIDOCS DEBUG DOCS EXAMPLES GMP RDOC
OPTIONS_DEFAULT=	RDOC LIBEDIT
OPTIONS_SINGLE=		EDIT
OPTIONS_SINGLE_EDIT=	LIBEDIT READLINE
OPTIONS_SUB=		yes
CAPIDOCS_DESC=		Build and install C API documents
GMP_DESC=		Use GMP to accelerate Bignum operations
RDOC_DESC=		Build and install Rdoc indexes
EDIT_DESC=		Which line editing lib to use
LIBEDIT_DESC=		Use libedit
READLINE_DESC=		Use libreadline
CAPIDOCS_BUILD_DEPENDS=	doxygen>=1.8.13,2:devel/doxygen \
			dot:graphics/graphviz
CAPIDOCS_CONFIGURE_ENABLE=	install-capi
GMP_CONFIGURE_WITH=	gmp
GMP_LIB_DEPENDS=	libgmp.so:math/gmp
LIBEDIT_CONFIGURE_ON=	--enable-libedit --with-libedit-dir=${LOCALBASE}
LIBEDIT_USES=		libedit
RDOC_CONFIGURE_ENABLE=	install-rdoc
READLINE_CONFIGURE_ON=	--disable-libedit --with-readline-dir=${LOCALBASE}
READLINE_USES=		readline

CPE_VENDOR=	ruby-lang
CPE_VERSION=	${RUBY_RELVERSION}
CPE_UPDATE=	p${RUBY_PATCHLEVEL}

.include <bsd.port.pre.mk>

# PORTREVISION/PORTEPOCH hack

.if ${PORTREVISION} != 0
_SUF1=	_${PORTREVISION}
.endif

.if ${PORTEPOCH} != 0
_SUF2=	,${PORTEPOCH}
.endif

CONFIGURE_ARGS+=--disable-dtrace

# keep in sync with all platforms where libunwind is available
.if (${ARCH} == amd64 || ${ARCH} == i386)
LIB_DEPENDS+=	libunwind.so:devel/libunwind
.endif

.if (${ARCH} == powerpc || ${ARCH} == powerpc64)
USE_GCC=	yes
.endif

.if ${ARCH} == armv6 || ${ARCH} == armv7
CONFIGURE_ARGS+=--with-setjmp-type=_setjmp
CONFIGURE_ENV+=	ac_cv_func__setjmp=yes
.endif

.if ${PORT_OPTIONS:MCAPIDOCS}
MAKE_JOBS_UNSAFE=	yes
.endif

.if ${RUBY_VER} == ${RUBY_DEFAULT_VER}
PLIST_SUB+=	IF_DEFAULT=""
.else
PKGNAMESUFFIX=	${RUBY_VER:C/\.//}
PLIST_SUB+=	IF_DEFAULT="@comment "
.endif

INSTALLED_SCRIPTS=	erb ruby
INSTALLED_MANUALS=	erb ruby

EXTSAMPLES=	bigdecimal/sample/*.rb

EXTDOCS=	readline/README			\
		ripper/README			\
		stringio/README.md		\
		syslog/syslog.txt

# Macros to change variables in rbconfig.rb
RB_SET_CONF_VAR=${SH} -c '${REINPLACE_CMD} -E -e "s,(CONFIG\[\"$$0\"\][[:space:]]*=[[:space:]]*)(\(?)(.*)(\)?),\1\2$$1\4," ${WRKSRC}/rbconfig.rb' --

post-patch:
# We get these from other ports
.for d in bin/bundle* bin/gem bin/*racc* bin/irb bin/rdoc bin/ri \
	  lib/bundler* libexec/bundler* \
	  man/bundle* man/gemfile* man/irb.1 man/ri.1 \
	  ext/dbm ext/gdbm ext/win32ole
	  	@${RM} -r ${BUILD_WRKSRC}/${d}
.endfor

post-build:
#
# Hack to allow modules to be installed into separate PREFIX and/or under user
# privileges
#
	@${RB_SET_CONF_VAR} "prefix" "ENV['PREFIX'] || \3"
	@${RB_SET_CONF_VAR} "INSTALL" "'/usr/bin/install -c'"
	@${RB_SET_CONF_VAR} "INSTALL_PROGRAM" "ENV['RB_USER_INSTALL'] ? '${INSTALL} ${COPY} ${STRIP} -m ${BINMODE}' : '${INSTALL_PROGRAM}'"
	@${RB_SET_CONF_VAR} "INSTALL_SCRIPT" "ENV['RB_USER_INSTALL'] ? '${INSTALL} ${COPY} -m ${BINMODE}' : '${INSTALL_SCRIPT}'"
	@${RB_SET_CONF_VAR} "INSTALL_DATA" "ENV['RB_USER_INSTALL'] ? '${INSTALL} ${COPY} -m ${SHAREMODE}' : '${INSTALL_DATA}'"

post-build-CAPIDOCS-on:
	@${FIND} ${WRKSRC}/doc -type d -empty -delete

pre-install:
	${MKDIR} ${STAGEDIR}${RUBY_SITEARCHLIBDIR}
	${MKDIR} ${STAGEDIR}${RUBY_VENDORARCHLIBDIR}

pre-install-DOCS-on:
	${MKDIR} ${STAGEDIR}${RUBY_DOCDIR}

pre-install-EXAMPLES-on:
	${MKDIR} ${STAGEDIR}${RUBY_EXAMPLESDIR}

pre-install-RDOC-on:
	${MKDIR} ${STAGEDIR}${RUBY_RIDIR}
	${MKDIR} ${STAGEDIR}${RUBY_SITERIDIR}

post-install:
.if ${RUBY_VER} == ${RUBY_DEFAULT_VER}
#
# Link just installed "ruby" to "ruby27", etc.
#
. for FILE in ${INSTALLED_SCRIPTS}
	${LN} -fs ${FILE}${RUBY_SUFFIX} ${STAGEDIR}${PREFIX}/bin/${FILE}
. endfor
#
# Link "ruby.1.gz" to "ruby27.1.gz", etc.
#
. for FILE in ${INSTALLED_MANUALS}
	${LN} -fs ${FILE}${RUBY_SUFFIX}.1.gz ${STAGEDIR}${MANPREFIX}/man/man1/${FILE}.1.gz
. endfor
.endif
	${REINPLACE_CMD} -e 's|${FAKE_DESTDIR}||g' \
                ${PREFIX}/bin/erb27 \
                ${PREFIX}/lib/ruby/2.7/${ARCH}-midnightbsd${OSMAJOR}/rbconfig.rb  \
                ${PREFIX}/libdata/pkgconfig/ruby-2.7.pc


post-install-DEBUG-off:
#
# XXX: hack to strip ruby binary. Ruby uses its own install script that seems
# bogus to hack.
#
.if defined(STRIP) && ${STRIP} == -s
	${STRIP_CMD} ${FAKE_DESTDIR}${PREFIX}/bin/ruby${RUBY_SUFFIX}
	${STRIP_CMD} ${FAKE_DESTDIR}${PREFIX}/lib/libruby${RUBY_SHLIBVER}.so.${RUBY_SHLIBVER}
	${FIND} ${FAKE_DESTDIR}${RUBY_ARCHLIBDIR} -type f -name '*\.so' -exec ${STRIP_CMD} {} \;
.endif

post-install-DOCS-on:
	# Create all dirs required (":u" isn't avaiable in STABLE yet :-()
	${MKDIR} ${EXTDOCS:C|^([^/]+)/.*|\1|:S|^|${FAKE_DESTDIR}${RUBY_DOCDIR}/|}
.for FILE in ${EXTDOCS}
	${INSTALL_DATA} ${WRKSRC}/ext/${FILE} \
		${FAKE_DESTDIR}${RUBY_DOCDIR}/${FILE:C|^([^/]+)/.*|\1|}/
.endfor
	@(cd ${WRKSRC}/doc/ && ${COPYTREE_SHARE} \* ${FAKE_DESTDIR}${RUBY_DOCDIR}/)
	${INSTALL_DATA} ${WRKSRC}/COPYING*	\
			${WRKSRC}/ChangeLog	\
			${WRKSRC}/LEGAL		\
			${WRKSRC}/README*	\
			${FAKE_DESTDIR}${RUBY_DOCDIR}/

post-install-EXAMPLES-on:
	# Create all dirs required (":u" isn't avaiable in STABLE yet :-()
	${MKDIR} ${EXTSAMPLES:C|^([^/]+)/.*|\1|:S|^|${FAKE_DESTDIR}${RUBY_EXAMPLESDIR}/|}
.for FILE in ${EXTSAMPLES}
	${INSTALL_DATA} ${WRKSRC}/ext/${FILE} \
		${FAKE_DESTDIR}${RUBY_EXAMPLESDIR}/${FILE:C|^([^/]+)/.*|\1|}/
.endfor
	(cd ${WRKSRC}/sample/ && ${COPYTREE_SHARE} . ${FAKE_DESTDIR}${RUBY_EXAMPLESDIR}/)

do-test:
	cd ${WRKSRC} && ${MAKE_CMD} test

.include <bsd.port.post.mk>
