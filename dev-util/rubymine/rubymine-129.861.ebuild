EAPI=4
inherit eutils
PVERSION='5.4.1'
#EAP='-EAP'
#http://download.jetbrains.com/ruby/RubyMine-5.4.1.tar.gz
HOMEPAGE="http://www.jetbrains.com/ruby/"
DESCRIPTION="he Most Intelligent Ruby and Rails IDE"
SRC_URI="http://download.jetbrains.com/ruby/RubyMine-${PVERSION}.tar.gz"

if [[ x${PVERSION} != 'x' ]]; then
	KEYWORDS="x86 amd64"
else
	KEYWORDS="~x86 ~amd64"
fi

PROGNAME="RubyMine"
RESTRICT="strip mirror"
DEPEND=">=virtual/jre-1.6"
SLOT="0"
S=${WORKDIR}
src_install() {
	dodir /opt/${PN}

	cd RubyMine*/
	insinto /opt/${PN}
	doins -r *

	fperms a+x /opt/${PN}/bin/rubymine.sh || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier64 || die "Chmod failed"
	dosym /opt/${PN}/bin/rubymine.sh /usr/bin/${PN}
	
	mv "bin/rubymine.png" "bin/${PN}.png"
	doicon "bin/${PN}.png"
	make_desktop_entry ${PN} "${PROGNAME}" "${PN}"
}
pkg_postinst() {
    elog "Run /usr/bin/${PN}"
}


