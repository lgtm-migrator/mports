PORTNAME=	scummvm
PORTVERSION=	2.1.0
PORTREVISION=	1
CATEGORIES=	games emulators
MASTER_SITES=	http://www.scummvm.org/frs/scummvm/${PORTVERSION}/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Interpreter for several adventure games

LICENSE=	gpl2
LICENSE_FILE=	${WRKSRC}/COPYING

LIB_DEPENDS=	libtheoradec.so:multimedia/libtheora \
		libfaad.so:audio/faad \
		libmpeg2.so:multimedia/libmpeg2 \
		libfreetype.so:print/freetype2

USE_GCC=	yes
USES=		gmake gnome iconv jpeg sdl tar:xz
HAS_CONFIGURE=	yes
USE_SDL=	sdl2
INSTALLS_ICONS=	yes

CONFIGURE_ARGS=	--prefix=${PREFIX} \
		--with-sdl-prefix=${LOCALBASE} \
		--with-jpeg-prefix=${LOCALBASE} \
		--disable-alsa \
		--with-zlib-prefix=/usr \
		--disable-debug \
		--disable-nasm \
		--disable-tremor \
		--enable-verbose-build

LDFLAGS+=	-lpthread

OPTIONS_DEFINE=	VORBIS MP3 PNG FLAC FLUIDSYNTH MT32EMU DOCS SNDIO
MT32EMU_DESC=	MT-32 emulator
OPTIONS_DEFAULT=	VORBIS MP3 PNG MT32EMU

VORBIS_LIB_DEPENDS=	libogg.so:audio/libogg \
			libvorbis.so:audio/libvorbis
VORBIS_CONFIGURE_ON=	--with-ogg-prefix=${LOCALBASE} \
			--with-vorbis-prefix=${LOCALBASE}
VORBIS_CONFIGURE_OFF=	--disable-vorbis

MP3_LIB_DEPENDS=	libmad.so:audio/libmad
MP3_CONFIGURE_ON=	--with-mad-prefix=${LOCALBASE}
MP3_CONFIGURE_OFF=	--disable-mad

PNG_LIB_DEPENDS=	libpng.so:graphics/png
PNG_CONFIGURE_ON=	--with-png-prefix=${LOCALBASE}
PNG_CONFIGURE_OFF=	--disable-png

FLAC_LIB_DEPENDS=	libFLAC.so:audio/flac
FLAC_CONFIGURE_ON=	--with-flac-prefix=${LOCALBASE}
FLAC_CONFIGURE_OFF=	--disable-flac

FLUIDSYNTH_LIB_DEPENDS=		libfluidsynth.so:audio/fluidsynth
FLUIDSYNTH_CONFIGURE_ON=	--with-fluidsynth-prefix=${LOCALBASE}
FLUIDSYNTH_CONFIGURE_OFF=	--disable-fluidsynth

MT32EMU_CONFIGURE_OFF=	--disable-mt32emu

SNDIO_LIB_DEPENDS=	libsndio.so:audio/sndio
SNDIO_CONFIGURE_ON=	--with-sndio-prefix=${LOCALBASE}
SNDIO_CONFIGURE_OFF=	--disable-sndio

.include <bsd.port.pre.mk>

post-patch:
	@${REINPLACE_CMD} -e '/^mandir=/s/datarootdir/prefix/' \
		${WRKSRC}/configure

post-install:
	${INSTALL_DATA} ${WRKSRC}/dists/${PORTNAME}.desktop \
		${STAGEDIR}${DESKTOPDIR}
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/${PORTNAME}

.include <bsd.port.post.mk>
