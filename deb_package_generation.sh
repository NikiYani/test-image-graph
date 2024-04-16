#!/bin/bash 
#
# Do not configure this file.
#

source utils.sh

if [ ! -z $1 ] 
then
    VERSION=$1
else
    VERSION="1.0.0.0"
fi

echo -e "$LIGHTGREEN=== START DEB-PACKAGE GENERATING ===$NC\n"

rm -rf deb_package

mkdir -p deb_package/testImageGraph/testImageGraph
mkdir deb_package/testImageGraph/DEBIAN
mkdir -p deb_package/testImageGraph/lib/systemd/system/

rsync -avP install_sh/ deb_package/testImageGraph/testImageGraph/

echo "Package: testImageGraph
Version: $VERSION 
Section: unknown  
Priority: optional
Architecture: arm64
Essential: no
Installed-Size: 15000
Maintainer: Nikita Yanchenkov
Description: testImageGraph
" > deb_package/testImageGraph/DEBIAN/control

echo "#!/bin/bash

if [ -e "/lib/systemd/system/testImageGraph.service" ]; then
    echo \"Test image graph service exists\"
    systemctl stop testImageGraph.service
    systemctl disable testImageGraph.service
fi

" > deb_package/testImageGraph/DEBIAN/preinst

chmod 555 deb_package/testImageGraph/DEBIAN/preinst

echo "#!/bin/bash

systemctl enable testImageGraph.service
systemctl daemon-reload

echo "Test image graph install success"
" > deb_package/testImageGraph/DEBIAN/postinst

chmod 555 deb_package/testImageGraph/DEBIAN/postinst

echo "[Unit]
Description=Test image graph
After=vm-platform.service
Wants=vm-platform.service
ConditionPathExists=!/var/lock/vm-platform-update.lock

[Service]
Type=simple
RestartSec=1s
Restart=always
Environment=LD_LIBRARY_PATH=/testImageGraph/lib/
Environment=QT_QPA_PLATFORM=linuxfb:mmsize=192x341
Environment=QT_QPA_FONTDIR=/usr/share/fonts/truetype
Environment=QT_FONT_DPI=64
WorkingDirectory=/
ExecStartPre=/bin/sleep 5
ExecStart=/testImageGraph/bin/testImageGraph

[Install]
WantedBy=multi-user.target
" > deb_package/testImageGraph/lib/systemd/system/testImageGraph.service

echo $VERSION > deb_package/testImageGraph/testImageGraph/version

rsync -avP resources deb_package/testImageGraph/testImageGraph

dpkg-deb --build ./deb_package/testImageGraph

rm -rf ./deb_package/testImageGraph  

cd deb_package
zip update.zip testImageGraph.deb
cd ..

echo -e "\n$LIGHTGREEN=== END DEB-PACKAGE GENERATING ===$NC\n"