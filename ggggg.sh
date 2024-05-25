#!/bin/bash
wget https://github.com/go-gost/gost/releases/download/v3.0.0-rc8/gost_3.0.0-rc8_linux_amd64v3.tar.gz
tar -zxvf gost_3.0.0-rc8_linux_amd64v3.tar.gz
mv gost /usr/local/bin/
chmod +x /usr/local/bin/gost

# 
echo "[Unit]
Description=Gost Proxy Service
After=network.target

[Service]
ExecStart=/usr/local/bin/gost \
-L \"http://gost:gost@:2080?limiter.in=5MB&limiter.out=5MB&climiter=111\" \
-L \"socks5://1234:1234@:10060?udp=true&limiter.in=100MB&limiter.out=100MB&climiter=500\" \
-L \"ss://aes-128-gcm:pass@:8338?limiter.in=5MB&limiter.out=5MB&climiter=111\" \
-L \"ssu+udp://aes-128-gcm:pass@:8338?limiter.in=5MB&limiter.out=5MB&climiter=111\"
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/gost.service

# 
sudo systemctl daemon-reload
sudo systemctl enable gost
sudo systemctl start gost