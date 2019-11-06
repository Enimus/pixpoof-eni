#!/bin/bash -ex 
apt update -y -q 
apt install -y -q libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen git nano dos2unix sshpass python3 python3-dev python-dev python-pip python3-pip python-setuptools 
git clone https://github.com/Enimus/pixpoof-eni.git /home/admin/pixpoof-eni 
cd /home/admin/pixpoof-eni/ 
chmod +x en1muspentest.sh 
echo /etc/crontab > 00 6 * * * root reboot 
cat > /lib/systemd/system/en1muspentest.service << EOF
[Unit] 
Description=en1muspentest
After=network.target 
[Service] 
ExecStart= /home/admin/pixpoof-eni/en1muspentest.sh 
User=root 
[Install] 
WantedBy=multi-user.target 
EOF
 
sudo systemctl daemon-reload 
sudo systemctl enable en1muspentest.service 
sudo systemctl start en1muspentest.service 
sudo systemctl stop en1muspentest.service 
sudo systemctl restart en1muspentest.service 

cat /etc/rc.0/enimus.sh << EOF
#!/bin/bash -ex 
apt update -y -q 
cd /home/admin/pixpoof-eni/ 
chmod +x en1muspentest.sh 
/home/admin/pixpoof-eni/en1muspentest.sh 
 
rm -r /etc/rc.local 
 
cat /etc/rc.local << EOF 
#!/bin/bash -ex 
/home/admin/pixpoof-eni/en1muspentest.sh 
EOF
 
EOF
 
   

 
 
