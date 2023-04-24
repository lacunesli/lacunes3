#!/bin/bash

#set -e
COL='\033[1;32m'
NC='\033[0m' # No Color
echo -e "${COL}Setting up KlipperScreen"

echo -e "${COL}Installing dependencies...\n${NC}"
apk add cmake xorg-server cairo-dev dbus dbus-libs gobject-introspection-dev py3-dbus-dev librsvg-dev gtk+3.0 terminus-font ttf-inconsolata ttf-dejavu font-noto font-noto-cjk ttf-font-awesome font-noto-extra font-isas-misc

echo -e "${COL}Downloading KlipperScreen\n${NC}"
#curl -o KlipperScreen.zip -L https://gitee.com/diy-3d/Octo4a/raw/master/KlipperScreen-master.zip
git clone https://gitee.com/Neko-vecter/KlipperScreen.git

#echo -e "${COL}Extracting klipperscreen\n${NC}"
#unzip KlipperScreen.zip
echo -e "${COL}Finished extracting\n${NC}"
#rm -rf KlipperScreen.zip
mv KlipperScreen /KlipperScreen

# pip3 install -U pip setuptools wheel

virtualenv /KlipperScreen-env
source /KlipperScreen-env/bin/activate
pip3 install -r /KlipperScreen/scripts/KlipperScreen-requirements.txt
deactivate

curl -o /root/klipper_config/KlipperScreen.conf -C - https://gitee.com/diy-3d/Octo4a/raw/master/KlipperScreen.conf

mkdir -p /root/extensions/KlipperScreen
cat << EOF > /root/extensions/KlipperScreen/manifest.json
{
        "title": "KlipperScreen plugin",
        "description": "klipper touchscreen GUI"
}
EOF

cat << EOF > /root/extensions/KlipperScreen/start.sh
#!/bin/sh
cd /KlipperScreen
DISPLAY=localhost:0 /KlipperScreen-env/bin/python3 /KlipperScreen/screen.py
EOF

cat << EOF > /root/extensions/KlipperScreen/kill.sh
#!/bin/sh
pkill -f 'screen\.py'
EOF
chmod +x /root/extensions/KlipperScreen/start.sh
chmod +x /root/extensions/KlipperScreen/kill.sh
chmod 777 /root/extensions/KlipperScreen/start.sh
chmod 777 /root/extensions/KlipperScreen/kill.sh


cat << EOF
KlipperScreen installed!
EOF