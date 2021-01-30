#!/bin/sh
# Source: https://phoenixnap.com/kb/how-to-install-python-3-ubuntu
#         https://phoenixnap.com/kb/how-to-install-pip-on-ubuntu
set -e

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.9

altno=1
if command -v python3.6; then
    update-alternatives --install /usr/bin/python python /usr/bin/python3.6 $altno
    ((altno++))
fi
update-alternatives --install /usr/bin/python python /usr/bin/python3.9 $altno
echo "===== Python Alternatives ====="
update-alternatives --display python
python --version
