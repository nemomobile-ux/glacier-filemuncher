Name:       glacier-filemuncher

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}

Summary:    File Manager for Nemo
Version:    0.2.1
Release:    1
Group:      Applications/System
License:    BSD
URL:        https://github.com/nemomobile-ux/glacier-filemuncher
Source0:    %{name}-%{version}.tar.bz2

Requires:   qt-components-qt5
Requires:   nemo-qml-plugin-thumbnailer-qt5
Requires:   nemo-qml-plugin-folderlistmodel
Requires:   libglacierapp >= 0.2

BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Gui)
BuildRequires:  pkgconfig(qdeclarative5-boostable)
BuildRequires:  pkgconfig(glacierapp) >= 0.2
BuildRequires:  desktop-file-utils

%description
File Manager using Qt Quick Components for Nemo Mobile.

%prep
%setup -q -n %{name}-%{version}

%build
%qtc_qmake5
%qtc_make %{?_smp_mflags}

%install
rm -rf %{buildroot}
%qmake5_install

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}/glacier-filemuncher
%{_datadir}/applications/glacier-filemuncher.desktop
%{_datadir}/glacier-filemuncher/
%{_libdir}/qt5/qml/org/nemomobile/filemuncher/*
