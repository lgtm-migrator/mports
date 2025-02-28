# Created by: Tony Maher

PORTNAME=	numpy
PORTVERSION=	1.16.6
PORTREVISION=	1
PORTEPOCH=	1
CATEGORIES=	math python
MASTER_SITES=	CHEESESHOP \
		https://docs.scipy.org/doc/${PORTNAME}-${PORTVERSION}/:doc \
		https://numpy.org/doc/${PORTVERSION:R}/:doc
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTFILES=	${DISTNAME}${EXTRACT_SUFX} \
		${PORTNAME}-ref-${PORTVERSION:R}.1.pdf:doc \
		${PORTNAME}-user-${PORTVERSION:R}.1.pdf:doc
EXTRACT_ONLY=	${DISTNAME}${EXTRACT_SUFX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	The New Numeric Extension to Python
WWW=		https://www.numpy.org/

LICENSE=	bsd3
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pytest>=0:devel/py-pytest@${PY_FLAVOR}

USES=		compiler:c11 fortran python:3.8-3.10 zip
USE_PYTHON=	allflavors autoplist concurrent cython distutils

GCCLIBDIR_CMDS=	${FC} -print-file-name=libgfortran.so | ${SED} -e s/libgfortran.so//
LDFLAGS+=	-shared
PYDISTUTILS_BUILDARGS=		--fcompiler=gnu95
PYDISTUTILS_CONFIGUREARGS=	--fcompiler=gnu95

PORTDOCS=	*

OPTIONS_DEFINE=		DOCS SUITESPARSE
OPTIONS_SINGLE=		BLASLIB
OPTIONS_SINGLE_BLASLIB=	ATLAS NETLIB OPENBLAS
OPTIONS_DEFAULT=	OPENBLAS SUITESPARSE
SUITESPARSE_DESC=	Use AMD and UMFPACK in SuiteSparse

ATLAS_USES=		blaslapack:atlas
ATLAS_VARS=		BLASLIBS="ptf77blas, ptcblas" BLASNAME=atlas LAPACKLIBS=alpack LIBRARIES=atlas_libs
NETLIB_USES=		blaslapack:netlib
NETLIB_VARS=		BLASLIBS="blas, cblas" BLASNAME=atlas LAPACKLIBS=lapack LIBRARIES=atlas_libs
NETLIB_LIB_DEPENDS=	libcblas.so:math/cblas
OPENBLAS_USES=		blaslapack:openblas
OPENBLAS_VARS=		BLASLIBS="openblas, gfortran" BLASNAME=openblas LAPACKLIBS="openblas, gfortran" LIBRARIES=libraries
SUITESPARSE_LIB_DEPENDS=libumfpack.so:math/suitesparse

NO_TEST=      yes

post-extract:
	@${TOUCH} ${WRKSRC}/numpy/f2py/tests/src/temp

post-patch:
	@${REINPLACE_CMD} -e 's|%%FC%%|${FC}|' ${WRKSRC}/numpy/distutils/fcompiler/gnu.py
	@${CP} ${FILESDIR}/site.cfg ${WRKSRC}/site.cfg

post-patch-SUITESPARSE-off:
	@${REINPLACE_CMD} -e 's|:%%LOCALBASE%%/include/suitesparse||' ${WRKSRC}/site.cfg

pre-configure:
	${REINPLACE_CMD} -e 's|%%LOCALBASE%%|${LOCALBASE}|g' \
		-e 's|%%BLASLIBS%%|${BLASLIBS}|; s|%%BLASNAME%%|${BLASNAME}|' \
		-e 's|%%LAPACKLIBS%%|${LAPACKLIBS}|; s|%%LIBRARIES%%|${LIBRARIES}|' \
			${WRKSRC}/site.cfg
	@${REINPLACE_CMD} -e "s|%%GCCLIBDIR%%|$$(${GCCLIBDIR_CMDS})|" ${WRKSRC}/site.cfg ${WRKSRC}/numpy/distutils/system_info.py

post-install:
	${FIND} ${STAGEDIR}${PYTHON_SITELIBDIR} -name '*.so' | ${XARGS} ${STRIP_CMD}

post-install-DOCS-on:
	@${MKDIR} ${FAKE_DESTDIR}${DOCSDIR}
	${INSTALL_DATA} ${DISTDIR}/${PORTNAME}-ref-${PORTVERSION:R}.1.pdf ${FAKE_DESTDIR}${DOCSDIR}
	${INSTALL_DATA} ${DISTDIR}/${PORTNAME}-user-${PORTVERSION:R}.1.pdf ${FAKE_DESTDIR}${DOCSDIR}

.include <bsd.port.mk>
