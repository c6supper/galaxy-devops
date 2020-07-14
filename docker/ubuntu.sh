
#!/bin/sh

set -xe

echo try install docker with $(logname)
#ask for sudo promotion
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
apt-get update
apt-get remove docker docker-engine docker.io docker-ce docker-ce-cli containerd runc
#apt-get -y install apt-transport-https ca-certificates curl software-properties-common
#curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
#add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
add-apt-repository \
	   "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
	      $(lsb_release -cs) \
	         stable"
apt-get -y update
apt-get -y install docker-ce
#curl -fsSL https://get.docker.com -o get-docker.sh
#sh get-docker.sh
usermod -aG docker $(logname)
gpasswd -a $USER docker
#curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose
#docker-compose --version

rm -rf /etc/docker/daemon.json
touch /etc/docker/daemon.json
cat >> /etc/docker/daemon.json << EOF
{
 "insecure-registries":["calvin.docker.mirror:5000"],
  "registry-mirrors": [
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn"
  ]
}
EOF
chmod 666 /var/run/docker.sock
service docker restart
