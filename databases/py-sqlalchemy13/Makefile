PORTNAME=	sqlalchemy
PORTVERSION=	1.3.23
CATEGORIES=	databases python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
PKGNAMESUFFIX=	13
DISTNAME=	SQLAlchemy-${PORTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Python SQL toolkit and Object Relational Mapper 1.3.x

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/LICENSE

TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}mock>=0:devel/py-mock@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}pytest>=2.5.2:devel/py-pytest@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}pytest-xdist>=0:devel/py-pytest-xdist@${PY_FLAVOR}

USES=		python:3.6+
USE_PYTHON=	autoplist concurrent distutils

PORTDOCS=	*
PORTEXAMPLES=	*

CONFLICTS_INSTALL=	${PYTHON_PKGNAMEPREFIX}sqlalchemy1[0124]

OPTIONS_DEFINE=	DOCS EXAMPLES
OPTIONS_MULTI=	BACKEND
OPTIONS_MULTI_BACKEND=	MSSQL MYSQL PGSQL SQLITE
OPTIONS_DEFAULT=SQLITE

MSSQL_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pymssql>=0:databases/py-pymssql@${PY_FLAVOR}
MYSQL_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pymysql>=0:databases/py-pymysql@${PY_FLAVOR}
PGSQL_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psycopg2>=2.5.0:databases/py-psycopg2@${PY_FLAVOR}
SQLITE_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}sqlite3>=0:databases/py-sqlite3@${PY_FLAVOR}

post-install:
	${STRIP_CMD} ${FAKE_DESTDIR}${PYTHON_SITELIBDIR}/sqlalchemy/*.so

post-install-DOCS-on:
	${MKDIR} ${FAKE_DESTDIR}${DOCSDIR}/
	cd ${WRKSRC}/doc/ && ${COPYTREE_SHARE} . ${FAKE_DESTDIR}${DOCSDIR}

post-install-EXAMPLES-on:
	${MKDIR} ${FAKE_DESTDIR}${EXAMPLESDIR}/
	cd ${WRKSRC}/examples/ && ${COPYTREE_SHARE} . ${FAKE_DESTDIR}${EXAMPLESDIR}

.include <bsd.port.mk>
