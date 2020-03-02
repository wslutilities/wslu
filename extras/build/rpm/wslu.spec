%define packager       Jinming Wu, Patrick <me@patrickwu.space>
Summary: Windows 10 Linux Subsystem Utilities
Name: wslu
Version: 3.0.0
Release: 1
Source: wslu-BUILDVERPLACEHOLDER.tar.gz
BuildArch: noarch
Requires: bc ImageMagick
Requires(post): %{_sbindir}/update-alternatives
Requires(postun): %{_sbindir}/update-alternatives
BuildRoot: %{_tmppath}/%{name}-%{version}-build
URL: https://github.com/wslutilities/wslu/
License: GPLv3

%description
This is a collection of utilities for Windows 10 Linux Subsystem, such as converting WSL path to Windows path or creating your favorite linux app shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update and higher.

%prep
%setup -q

%build
make

%install
make PREFIX=/usr DESTDIR=%{?buildroot} install

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
%{_bindir}/wslgsu
%{_bindir}/wslact
%{_bindir}/wslvar
/usr/share/wslu/
%doc /usr/share/man/

%changelog
* Wed Mar 10 2020 Jinming Wu, Patrick <me@patrickwu.space>
- Please check https://github.com/wslutilities/wslu/releases/latest for changelog

