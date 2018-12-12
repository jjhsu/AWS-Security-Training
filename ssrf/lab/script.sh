#!/bin/bash
sudo yum -y update
sudo yum-config-manager --enable epel
sudo yum -y install git python-pip supervisor
sudo curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python get-pip.py
sudo mkdir /app
cd /app/
sudo git clone https://github.com/we45/helloworld_ssrf.git
sudo chmod +x /app/helloworld_ssrf/app.py
sudo ln -s /usr/local/bin/pip /bin/pip
sudo pip install -r /app/helloworld_ssrf/requirements.txt
sleep 10
sudo nohup python /app/helloworld_ssrf/app.py &
echo "Python Service is running now"
sudo ps ax | grep app.py
