#!/usr/bin/env bash
BUILD_VER=`grep 'version=' ../../src/wslu | cut -d'=' -f 2 | xargs`
CURRENT_DIR=`pwd`

mkdir -p ~/rpm_wslu/{BUILD/,RPMS/,SOURCES/,SPECS/,SRPMS/}


mkdir ~/rpm_wslu/SOURCES/wslu-$BUILD_VER
cp ../../src/wsl* ~/rpm_wslu/SOURCES/wslu-$BUILD_VER
cd ~/rpm_wslu/SOURCES
tar -czvf wslu-${BUILD_VER}.tar.gz wslu-$BUILD_VER
rm -rf tmp

cat <<EOF >> ~/rpm_wslu/SPECS/wslu-$BUILD_VER.spec
%define packager       patrick330602 <wotingwu@live.com>

%define _topdir        $HOME/rpm_wslu
%define _tmppath       /var/tmp
 
%define _rpmtopdir     %{_topdir}
%define _builddir      %{_rpmtopdir}/BUILD
%define _rpmdir        %{_rpmtopdir}/RPMS
%define _sourcedir     %{_rpmtopdir}/SOURCES
%define _specdir       %{_rpmtopdir}/SPECS
%define _srcrpmdir     %{_rpmtopdir}/SRPMS
Summary: Windows 10 Linux Subsystem Utilities
Name: wslu
Version: $BUILD_VER
Release: 1
URL: https://github.com/patrick330602/wslu/
License: GPL
%description
This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux app shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update and higher.
%prep
%setup
%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p ${RPM_BUILD_ROOT}/usr/bin
install -m 755 wsl* ${RPM_BUILD_ROOT}/usr/bin
%clean
rm -rf $RPM_BUILD_ROOT
%files
%defattr(-,root,root)
%attr(755,root,root) /usr/bin/wsl*
%changelog
* Fri May 11 2018 patrick330602 <wotingwu@live.com>
- First rpm build of wslu.
EOF

cd ~/rpm_wslu/SPECS
rpmbuild -ba wslu-$BUILD_VER.spec