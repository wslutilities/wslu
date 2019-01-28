%define packager       patrick330602 <wotingwu@live.com>

%define _topdir        HOMEPLACEHOLDER/rpm_wslu
%define _tmppath       /var/tmp
 
%define _rpmtopdir     %{_topdir}
%define _builddir      %{_rpmtopdir}/BUILD
%define _rpmdir        %{_rpmtopdir}/RPMS
%define _sourcedir     %{_rpmtopdir}/SOURCES
%define _specdir       %{_rpmtopdir}/SPECS
%define _srcrpmdir     %{_rpmtopdir}/SRPMS
Summary: Windows 10 Linux Subsystem Utilities
Name: wslu
Version: BUILDVERPLACEHOLDER
Release: 1
Source: wslu-BUILDVERPLACEHOLDER.tar.gz
Requires: bc ImageMagick
Requires(post): %{_sbindir}/update-alternatives
Requires(postun): %{_sbindir}/update-alternatives
URL: https://github.com/wslutilities/wslu/
License: GPLv3
%description
This is a collection of utilities for Windows 10 Linux Subsystem, such as converting WSL path to Windows path or creating your favorite linux app shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update and higher.
%global debug_package %{nil}
%prep
%setup
%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p ${RPM_BUILD_ROOT}/usr/bin
install -m555 -d ${RPM_BUILD_ROOT}/usr/share/wslu
install -m755 wsl* ${RPM_BUILD_ROOT}%{_bindir}
install -m555 docs/wsl* ${RPM_BUILD_ROOT}%{_mandir}/man1
cp -a etc/* ${RPM_BUILD_ROOT}/usr/share/wslu

%post
%{_sbindir}/update-alternatives --install %{_bindir}/www-browser www-browser %{_bindir}/wslview 1
%{_sbindir}/update-alternatives --install %{_bindir}/x-www-browser x-www-browser %{_bindir}/wslview 1

%postun
%{_sbindir}/update-alternatives --remove www-browser %{_bindir}/wslview
%{_sbindir}/update-alternatives --remove x-www-browser %{_bindir}/wslview

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%{_bindir}/wslusc
%{_bindir}/wslfetch
%{_bindir}/wslsys
%{_bindir}/wslupath
%{_bindir}/wslview
%{_bindir}/wslvar
/usr/share/wslu/runHidden.vbs
/usr/share/wslu/wsl.ico
%{_mandir}/man1/

%changelog
* Sat Jan 12 2019 patrick330602 <wotingwu@live.com>
- Please check https://github.com/wslutilities/wslu/releases/lstest for changelog

