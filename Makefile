PORTNAME=	orcacubic
DISTVERSION=	g20260910
CATEGORIES=	print

MAINTAINER=	pypipackages01@tspi.at
COMMENT=	OrcaCubic slicer with Kobra X LAN support
WWW=		https://github.com/marcodiniz/OrcaCubic

LICENSE=	AGPLv3
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

BUILD_DEPENDS=	cereal>=1.3:devel/cereal \
		cgal>=5:math/cgal \
		nlohmann-json>=3:devel/nlohmann-json
LIB_DEPENDS=	libassimp.so:multimedia/assimp \
		libboost_log.so:devel/boost-libs \
		libcurl.so:ftp/curl \
		libdraco.so:archivers/draco \
		libexpat.so:textproc/expat2 \
		libavcodec.so:multimedia/ffmpeg \
		libavutil.so:multimedia/ffmpeg \
		libswscale.so:multimedia/ffmpeg \
		libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2 \
		libglfw.so:graphics/glfw \
		libgmp.so:math/gmp \
		libhidapi.so:comms/hidapi \
		libnoise.so:audio/libnoise \
		libnlopt.so:math/nlopt \
		libopenvdb.so:misc/openvdb \
		libmpfr.so:math/mpfr \
		libpng16.so:graphics/png \
		libqhull_r.so:math/qhull \
		libsecret-1.so:security/libsecret \
		libsoup-3.0.so:devel/libsoup3 \
		libtbb.so:devel/onetbb \
		libTKDESTEP.so:cad/opencascade \
		libwebkit2gtk-4.1.so:www/webkit2-gtk@41

USES=		cmake compiler:c++17-lang eigen:3 \
		gettext gl gnome jpeg pkgconfig python:3.11 ssl xorg
USE_GL=		gl glu glew
USE_GNOME=	gtk30 pango atk cairo gdkpixbuf glib20
USE_WX=		3.2
USE_XORG=	x11 xext sm ice
USE_GITHUB=	yes
GH_ACCOUNT=	marcodiniz
GH_PROJECT=	OrcaCubic
GH_TAGNAME=	822ae314016642d0ed2a362d38ebf15f03852300
GH_TUPLE=	Noisyfox:wxInspector:v1.0.0:wxinspector
PATCH_STRIP=	-p1

# Keep the existing /usr/local/bin/orca-slicer and share/OrcaSlicer untouched.
# This port uses a private executable/resource tree plus a unique launcher.
CMAKE_INSTALL_PREFIX=	${PREFIX}/libexec/OrcaCubic
CMAKE_ARGS=	-DCMAKE_BUILD_TYPE=Release \
		-DSLIC3R_STATIC=OFF \
		-DSLIC3R_GUI=ON \
		-DSLIC3R_GTK=3 \
		-DSLIC3R_FHS=OFF \
		-DBUILD_TESTS=OFF \
		-DOPENVDB_FIND_MODULE_PATH=${LOCALBASE}/lib/cmake/OpenVDB \
		-DFETCHCONTENT_SOURCE_DIR_WXINSPECTOR=${WRKSRC_wxinspector} \
		-DPython3_EXECUTABLE=${PYTHON_CMD} \
		-Wno-dev

SUB_FILES=	orcacubic com.orcacubic.OrcaCubic.desktop
PLIST_FILES=	bin/orcacubic \
		share/applications/com.orcacubic.OrcaCubic.desktop \
		share/icons/hicolor/32x32/apps/orcacubic.png \
		share/icons/hicolor/128x128/apps/orcacubic.png \
		share/icons/hicolor/192x192/apps/orcacubic.png

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/libexec/OrcaCubic/bin
	${MKDIR} ${STAGEDIR}${PREFIX}/libexec/OrcaCubic/resources
	${INSTALL_PROGRAM} ${BUILD_WRKSRC}/src/orca-slicer \
		${STAGEDIR}${PREFIX}/libexec/OrcaCubic/bin/orca-slicer
	${INSTALL_DATA} ${WRKSRC}/LICENSE.txt \
		${STAGEDIR}${PREFIX}/libexec/OrcaCubic/LICENSE.txt
	(cd ${WRKSRC}/resources && ${COPYTREE_SHARE} . \
		${STAGEDIR}${PREFIX}/libexec/OrcaCubic/resources)
	${INSTALL_SCRIPT} ${WRKDIR}/orcacubic ${STAGEDIR}${PREFIX}/bin/orcacubic
	${MKDIR} ${STAGEDIR}${PREFIX}/share/applications
	${INSTALL_DATA} ${WRKDIR}/com.orcacubic.OrcaCubic.desktop \
		${STAGEDIR}${PREFIX}/share/applications/com.orcacubic.OrcaCubic.desktop
.for size in 32 128 192
	${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/${size}x${size}/apps
	${INSTALL_DATA} ${WRKSRC}/resources/images/OrcaSlicer_${size}px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/${size}x${size}/apps/orcacubic.png
.endfor
	@cd ${STAGEDIR}${PREFIX} && ${FIND} libexec/OrcaCubic -type f | ${SORT} >> ${TMPPLIST}

.include <bsd.port.mk>
