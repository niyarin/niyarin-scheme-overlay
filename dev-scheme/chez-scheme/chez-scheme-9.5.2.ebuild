# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils

DESCRIPTION="Chez Scheme is an implementation of the Revised 6 Report on Scheme (R6RS) with numerous language and programming environment extensions."
HOMEPAGE="https://cisco.github.io/ChezScheme"


NANOPASS_PV="1.9"
NANOPASS_P="nanopass-framework-scheme-${NANOPASS_PV}"
NANOPASS_URI="https://github.com/nanopass/nanopass-framework-scheme/archive/v${NANOPASS_PV}.tar.gz"

ZLIB_PV="1.2.11"
ZLIB_P="zlib-${ZLIB_PV}"
ZLIB_URI="https://github.com/madler/zlib/archive/v${PV}.tar.gz"

ZLIB_PV="1.2.1"
STEX_P="stex-${ZLIB_PV}"
STEX_URI="https://github.com/dybvig/stex/archive/v1.2.1.tar.gz"

SRC_URI="https://github.com/cisco/ChezScheme/archive/v${PV}.tar.gz -> ${PF}.tar.gz
		${ZLIB_URI} -> ${ZLIB_P}.tar.gz
		${STEX_URI} -> ${STEX_P}.tar.gz
		${NANOPASS_URI} -> ${NANOPASS_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+threads"

DEPEND="
	sys-libs/ncurses "

RDEPEND="${DEPEND}"

src_configure() {
	local para_thread

	if use threads ; then
	   para_thread="--threads"
	fi

	./configure \
	${para_thread} \
	--installprefix=/usr \
	--installbin=/usr/bin \
	--installlib=/usr/lib \
	--installman=/usr/share/man \
	--temproot=${D}
}

src_install() {
	emake install
}

src_unpack() {
	unpack ${A}
	mv ChezScheme-${PV} ${PF}
	mv ${NANOPASS_P}/* ${PF}/nanopass
	mv ${STEX_P}/* ${PF}/stex
	mv ${ZLIB_P}/* ${PF}/zlib

echo 'diff -ur c/Mf-a6le c2/Mf-a6le
--- c/Mf-a6le	2019-03-22 07:05:24.000000000 +0900
+++ c2/Mf-a6le	2019-08-26 07:34:29.914948586 +0900
@@ -16,7 +16,7 @@
 m = a6le
 Cpu = X86_64
 
-mdclib = -lm -ldl -lncurses -lrt -luuid
+mdclib = -lm -ldl -lncurses -lrt -luuid -ltinfo
 C = ${CC} ${CPPFLAGS} -m64 -msse2 -Wpointer-arith -Wall -Wextra -Werror -Wno-implicit-fallthrough -O2 ${CFLAGS}
 o = o
 mdsrc = i3le.c
diff -ur c/Mf-i3le c2/Mf-i3le
--- c/Mf-i3le	2019-03-22 07:05:24.000000000 +0900
+++ c2/Mf-i3le	2019-08-26 07:34:13.422852525 +0900
@@ -16,7 +16,7 @@
 m = i3le
 Cpu = I386
 
-mdclib = -lm -ldl -lncurses -lrt -luuid
+mdclib = -lm -ldl -lncurses -lrt -luuid -ltinfo
 C = ${CC} ${CPPFLAGS} -m32 -msse2 -Wpointer-arith -Wall -Wextra -Werror -Wno-implicit-fallthrough -O2 -fno-stack-protector ${CFLAGS}
 o = o
 mdsrc = i3le.c
diff -ur c/Mf-ta6le c2/Mf-ta6le
--- c/Mf-ta6le	2019-03-22 07:05:24.000000000 +0900
+++ c2/Mf-ta6le	2019-08-26 07:32:47.664953137 +0900
@@ -16,7 +16,7 @@
 m = ta6le
 Cpu = X86_64
 
-mdclib = -lm -ldl -lncurses -lpthread -lrt -luuid
+mdclib = -lm -ldl -lncurses -lpthread -lrt -luuid -ltinfo
 C = ${CC} ${CPPFLAGS} -m64 -msse2 -Wpointer-arith -Wall -Wextra -Werror -Wno-implicit-fallthrough -O2 -D_REENTRANT -pthread ${CFLAGS}
 o = o
 mdsrc = i3le.c
diff -ur c/Mf-ti3le c2/Mf-ti3le
--- c/Mf-ti3le	2019-03-22 07:05:24.000000000 +0900
+++ c2/Mf-ti3le	2019-08-26 07:33:25.493760984 +0900
@@ -16,7 +16,7 @@
 m = ti3le
 Cpu = I386
 
-mdclib = -lm -ldl -lncurses -lpthread -lrt -luuid
+mdclib = -lm -ldl -lncurses -lpthread -lrt -luuid -ltinfo
 C = ${CC} ${CPPFLAGS} -m32 -msse2 -Wpointer-arith -Wall -Wextra -Werror -Wno-implicit-fallthrough -O2 -D_REENTRANT -pthread ${CFLAGS}
 o = o
 mdsrc = i3le.c'|patch -p0 -d${PF}
}
