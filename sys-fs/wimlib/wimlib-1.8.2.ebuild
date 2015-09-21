# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="Library for manipulating and mounting Windows Imaging Format files"
HOMEPAGE="http://wimlib.sourceforge.net/"
SRC_URI="http://wimlib.net/downloads/${P}.tar.gz
	http://wimlib.net/gitlist/wimlib/raw/v1.8.2/build-aux/nasm_lt.sh -> ${P}-nasm_lt.sh"

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fuse ntfs3g openssl +smp ssse3"

REQUIRED_USE="ssse3? ( !openssl )"

RDEPEND="
	dev-libs/libxml2
	virtual/pkgconfig
	virtual/libiconv
	fuse? ( sys-apps/attr sys-fs/fuse )
	ntfs3g? ( sys-fs/ntfs3g )
	openssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	ssse3? ( dev-lang/nasm )"

src_prepare() {
	cp ${DISTDIR}/${P}-nasm_lt.sh ${S}/build-aux/nasm_lt.sh
	chmod +x ${S}/build-aux/nasm_lt.sh
	eautoreconf
	echo "section .note.GNU-stack progbits" >> src/sha1-ssse3.asm
}

src_configure() {
	local myconf="
		$(use_with fuse)
		$(use_with ntfs3g ntfs-3g)
		$(use_enable smp multithreaded-compression)
		$(use_enable ssse3 ssse3-sha1)
		$(use_with openssl libcrypto)"
	econf ${myconf}
}
