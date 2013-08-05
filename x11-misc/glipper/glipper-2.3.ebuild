EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils gnome2-utils

DESCRIPTION="A PyGTK+ based advanced clipboard manager"
HOMEPAGE="http://launchpad.net/glipper"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
    dev-libs/keybinder:0[python]
	>=dev-libs/libappindicator-0.4:0
	dev-python/gconf-python
	dev-python/pycrypto
	dev-python/pygtk:2
	dev-python/python-prctl
	dev-python/pyxdg
	"
DEPEND="
	${RDEPEND}
	dev-python/python-distutils-extra
	"

src_install() {
	distutils_src_install

	dodir /etc
	mv -vf "${ED}"/usr/share/gconf "${ED}"/etc
}

pkg_preinst() {
	gnome2_gconf_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_gconf_install
	gnome2_icon_cache_update
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_icon_cache_update
}
