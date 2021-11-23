#!/bin/bash

############################################################
# Install Docker and enable it as a service
############################################################
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y dnf
sudo dnf install -y dnf-utils
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf remove -y runc
sudo dnf install -y docker-ce --nobest
sudo systemctl enable docker.service
sudo systemctl start docker.service

############################################################
# Install Docker Compose plugin as root
# That's because docker-commands require root privileges
############################################################
sudo su -
sudo curl -L --create-dirs "https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-$(uname -s)-aarch64" -o ~/.docker/cli-plugins/docker-compose
sudo chmod +x ~/.docker/cli-plugins/docker-compose
logout

sudo docker -v
sudo docker compose -v

############################################################
# Install latest Lynx_BOT version
############################################################
finalurl() { curl --silent --location --head --output /dev/null --write-out '%{url_effective}' -- "$@";}

latestRelease=`finalurl https://github.com/lynx-chess/Lynx_BOT/releases/latest`

version=`expr match "$latestRelease" '.*\(v.*\)'`
version="${version:1}"

wget $latestRelease/Lynx_BOT-$version.zip

unzip Lynx_BOT-$version.zip -d Lynx_BOT-$version

cd Lynx_BOT-$version
$ cat <<EOF > .env
LICHESS_API_TOKEN="$LYNX_BOT_TOKEN"
EOF
# docker compose up -d
cd ..

############################################################
# Install latest lichess-challenger version
############################################################
latestRelease=`finalurl https://github.com/lynx-chess/lichess-challenger/releases/latest`

version=`expr match "$latestRelease" '.*\(v.*\)'`
version="${version:1}"

mkdir lichess-challenger-$version
cd lichess-challenger-$version
wget https://raw.githubusercontent.com/lynx-chess/lichess-challenger/main/docker-compose.yml
sed -i "s/latest/$version/g" docker-compose.yml
$ cat <<EOF > .env
LICHESS_API_TOKEN="$LICHESS_CHALLENGER_TOKEN"
LICHESS_USERNAME="Lynx_BOT"
EOF
# docker compose up -d
cd ..