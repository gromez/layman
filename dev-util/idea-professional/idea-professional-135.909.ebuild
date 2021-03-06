EAPI=4
inherit eutils
#EAP='-EAP'
PVERSION='13.1.3'
HOMEPAGE="http://www.jetbrains.com/idea/"
DESCRIPTION="JetBrains idea Professional Edition EAP release 13.1.3, Non free used, use license"
SRC_URI="http://download.jetbrains.com/idea/ideaIU-${PVERSION:-${PV}}.tar.gz"

if [[ x${PVERSION} != 'x' ]]; then
	KEYWORDS="x86 amd64"
else
	KEYWORDS="~x86 ~amd64"
fi

PROGNAME="Idea Professional"
RESTRICT="strip mirror"
DEPEND=">=virtual/jre-1.6"
SLOT="0"
S=${WORKDIR}
src_install() {
	dodir /opt/${PN}

	cd idea-IU*/
	insinto /opt/${PN}
	doins -r *

	fperms a+x /opt/${PN}/bin/idea.sh || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier64 || die "Chmod failed"
	dosym /opt/${PN}/bin/idea.sh /usr/bin/${PN}
	
	mv "bin/idea.png" "bin/${PN}.png"
	doicon "bin/${PN}.png"
	make_desktop_entry ${PN} "${PROGNAME}" "${PN}"
}
pkg_postinst() {
    elog "Run /usr/bin/${PN}"
}


