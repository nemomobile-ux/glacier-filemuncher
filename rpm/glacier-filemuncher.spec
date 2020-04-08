Name:       glacier-filemuncher
Summary:    File Manager for Nemo
Version:    0.2.1
Release:    2
Group:      Applications/System
License:    BSD
URL:        https://github.com/nemomobile-ux/glacier-filemuncher
Source0:    %{name}-%{version}.tar.bz2

Requires:   qt5-qtquickcontrols-nemo
Requires:   nemo-qml-plugin-thumbnailer-qt5
Requires:   nemo-qml-plugin-folderlistmodel >= 0.13
Requires:   libglacierapp
Requires:   mapplauncherd-booster-nemomobile

BuildRequires:  cmake
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Gui)
BuildRequires:  pkgconfig(qdeclarative5-boostable)
BuildRequires:  pkgconfig(glacierapp)
BuildRequires:  desktop-file-utils

%description
File Manager using Qt Quick Components for Nemo Mobile.

%prep
%setup -q -n %{name}-%{version}

%build
mkdir build
cd build
cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=%{_prefix} \
	-DCMAKE_INSTALL_LIBDIR=%{_lib} \
	-DCMAKE_VERBOSE_MAKEFILE=ON \
	..
cmake --build .

%install
cd build
rm -rf %{buildroot}
DESTDIR=%{buildroot} cmake --build . --target install

%files
%defattr(-,root,root,-)
%{_bindir}/glacier-filemuncher
%{_datadir}/applications/glacier-filemuncher.desktop
%{_datadir}/glacier-filemuncher/
%{_libdir}/qt5/qml/org/nemomobile/filemuncher/*
