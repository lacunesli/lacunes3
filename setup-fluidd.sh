#!/bin/bash

set -e
COL='\033[1;32m'
NC='\033[0m' # No Color
echo -e "${COL}Setting up fluidd"

echo -e "${COL}Installing dependencies...\n${NC}"
# install required dependencies
apk add curl nginx openrc

echo -e "${COL}Downloading fluidd\n${NC}"
mkdir /fluidd && cd /fluidd
curl -o fluidd.zip -L https://gitee.com/Neko-vecter/fluidd-releases/releases/download/v1.23.1/fluidd.zip

echo -e "${COL}Extracting fluidd\n${NC}"
unzip fluidd.zip
rm -rf fluidd.zip

# TODO: curl and mv nginx conf
curl -o /etc/nginx/http.d/fluidd.conf -C - https://gitee.com/diy-3d/octo4a-klipper/raw/master/fluidd.conf

# TODO: sed nginx user root

# nginx serves ts as wrong mimetype
# video/mp2t                                       ts;
#text/javascript			ts;

mkdir -p /root/extensions/fluidd
cat << EOF > /root/extensions/fluidd/manifest.json
{
        "title": "fluidd plugin",
        "description": "klipper web interface"
}
EOF

cat << EOF > /root/extensions/fluidd/start.sh
#!/bin/sh
nginx
EOF

cat << EOF > /root/extensions/fluidd/kill.sh
#!/bin/sh
nginx -s stop
EOF

chmod +x /root/extensions/fluidd/start.sh
chmod +x /root/extensions/fluidd/kill.sh
chmod 777 /root/extensions/fluidd/start.sh
chmod 777 /root/extensions/fluidd/kill.sh

cat << EOF
fluidd installed!
EOF