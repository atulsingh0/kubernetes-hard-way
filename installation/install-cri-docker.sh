sudo -i

VERSION="0.2.6"

wget https://github.com/Mirantis/cri-dockerd/releases/download/v$VERSION/cri-dockerd-$VERSION.amd64.tgz
tar xvf cri-dockerd-$VERSION.amd64.tgz
sudo mv ./cri-dockerd/cri-dockerd /usr/local/bin/

wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service
wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket
sudo mv cri-docker.socket cri-docker.service /etc/systemd/system/
sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service

sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket
sudo systemctl status cri-docker.socket
