# Maintainer: Patrick Wu <wotingwu@live.com>

pkgname=wslu
pkgver=2.0.0rc1
pkgrel=3
pkgdesc="A collection of utilities for Windows 10 Linux Subsystems"
arch=('any')
url='https://github.com/wslutilities/wslu'
license=('GPL3')
depends=('bc' 'imagemagick' 'bash-completion' 'wget' 'unzip')
makedepends=('git' 'make')
source=("git+https://github.com/wslutilities/wslu.git#tag=v${pkgver}")
sha256sums=('SKIP')

build() {
  cd wslu
  make
}

package() {
  cd wslu

    install -Dm 755 out/* -t "${pkgdir}"/usr/bin/
  install -Dm 555 docs/* -t "${pkgdir}"/usr/share/man/man1/
  install -Dm 555 src/etc/* -t "${pkgdir}"/usr/share/wslu/
  install -Dm 644 LICENSE -t "${pkgdir}"/usr/share/licenses/wslu/
}

# vim: ts=2 sw=2 et: