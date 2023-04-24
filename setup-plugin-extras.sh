#!/bin/sh

#set -e
wget https://gitee.com/diy-3d/Octo4a/raw/master/setup-build-environment.sh
curl -s https://gitee.com/diy-3d/Octo4a/raw/master/setup-klipper.sh | bash -s
curl -s https://gitee.com/diy-3d/Octo4a/raw/master/setup-moonraker.sh | bash -s
curl -s https://gitee.com/diy-3d/Octo4a/raw/master/setup-mainsail.sh | bash -s
#curl -s https://gitee.com/diy-3d/Octo4a/raw/master/setup-KlipperScreen.sh | bash -s