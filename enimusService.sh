#!/bin/bash -ex 
apt update -y -q 
apt install -y -q git dirmngr software-properties-common 
git clone https://github.com/Enimus/pixpoof-eni.git /home/admin/pixpoof-eni 
cd /home/admin/pixpoof-eni/ 
chmod +x * 
cat > /lib/systemd/system/enimus.service << EOF
[Unit] 
Description=enimus
After=network.target 
[Service] 
ExecStart=/home/admin/pixpoof-eni/enimusPEN.sh 
User=root 
[Install] 
WantedBy=multi-user.target 
EOF
systemctl daemon-reload 
systemctl enable enimus.service 
systemctl restart enimus.service 
 
  
  
