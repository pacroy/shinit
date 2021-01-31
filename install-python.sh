#!/bin/sh
# Source: https://phoenixnap.com/kb/how-to-install-python-3-ubuntu
#         https://hackersandslackers.com/multiple-versions-python-ubuntu
#         https://phoenixnap.com/kb/how-to-install-pip-on-ubuntu
#         https://pip.pypa.io/en/stable/installing/
set -e

sudo apt update
sudo apt install -y python3 python3-pip
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
sudo update-alternatives --display python
python --version
python -m pip install -U pip
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
sudo update-alternatives --display pip
python -m pip --version
