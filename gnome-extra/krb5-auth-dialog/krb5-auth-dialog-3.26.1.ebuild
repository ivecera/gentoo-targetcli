# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2

DESCRIPTION="Kerberos 5 authentication dialog"
HOMEPAGE="https://honk.sigxcpu.org/piki/projects/krb5-auth-dialog/"
SRC_URI="http://download.gnome.org/sources/krb5-auth-dialog/3.26/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="caps networkmanager pam"

RDEPEND="virtual/krb5
		>=dev-libs/dbus-glib-0.80
		>=dev-libs/glib-2.28
		>=gnome-base/gconf-2.31
		>=x11-libs/gtk+-3.14
		>=x11-libs/libnotify-0.7
		caps? ( sys-libs/libcap )
		networkmanager? ( net-misc/networkmanager )
		pam? ( sys-libs/pam )"
DEPEND="${RDEPEND}"

GNOME2_EAUTORECONF="yes"

src_prepare() {
	epatch "${FILESDIR}/appdatadir.patch"

	gnome2_src_prepare
}

src_configure() {
	local myconf

	gnome2_src_configure								\
		$(use_with caps libcap)							\
		$(use_enable networkmanager network-manager)	\
		$(use_with pam)
}
