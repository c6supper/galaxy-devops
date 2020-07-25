#!/bin/sh

set -xe
echo try install docker with $(logname)
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

position="veex_en"
if [ -n $1 ]; then
    position=$1
fi
version="8"
if [ -n $2 ]; then
    version=$2
fi

#if in chengdu, replace default source list
if [ "$position" = "veex_cn" ]; then
    yum install -y wget
    if [ "$version" = "7"  ]; then
    	wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
    else
	wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo
    fi
fi

yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotatdocker-engine \
		  docker-engine \
                  docker-ce

yum install -y yum-utils device-mapper-persistent-data lvm2

wget -O /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo

if [ "$position" = "veex_cn" ]; then
    yum-config-manager \
        --add-repo \
        http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    #sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo
else
    yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
fi

yum makecache

if [ "$version" = "8" ]; then
   yum install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
   yum install -y docker-ce docker-ce-cli
   # Allows container to container communication, the solution to the problem
   firewall-cmd --zone=public --add-masquerade --permanent

   # standard http & https stuff
   firewall-cmd --zone=public --add-port=80/tcp --permanent
   firewall-cmd --zone=public --add-port=443/tcp --permanent
   # + any other port you may need
   firewall-cmd --zone=public --add-port=1194/tcp --permanent
   firewall-cmd --zone=public --add-port=1195/tcp --permanent
   firewall-cmd --zone=public --add-port=1196/tcp --permanent
   # reload the firewall
   firewall-cmd --reload
else
   yum install -y docker-ce docker-ce-cli containerd.io
fi

usermod -aG docker $(logname)
gpasswd -a $USER docker

#install docker-compose
if [ "$position" = "veex_cn" ]; then
    curl -L "https://get.daocloud.io/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
else
    curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
fi
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

if [ "$position" = "veex_cn" ]; then
    rm -rf /etc/docker/daemon.json
    mkdir -p /etc/docker
    touch /etc/docker/daemon.json
    cat >> /etc/docker/daemon.json << EOF
    {
      "registry-mirrors": [
        "https://registry.docker-cn.com",
        "https://7y3a2yxf.mirror.aliyuncs.com"
      ]
    }
EOF
fi

systemctl stop docker
sleep 5
systemctl start docker
