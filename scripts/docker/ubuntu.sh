
#!/bin/sh

apt-get remove docker docker-engine docker.io docker-ce docker-ce-cli
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker c6supper
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

rm -rf /etc/docker/daemon.json
touch /etc/docker/daemon.json
cat >> /etc/docker/daemon.json << EOF
{
    "registry-mirrors": ["https://registry.docker-cn.com"]
} 
EOF

service docker restart