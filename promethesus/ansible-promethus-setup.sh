#!/bin/bash
######Ansible installation and prometheus server installation on ubuntu#############
install_ansible()
{
echo "ansible setup"
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt install ansible -y

}

install_prometheus()
{
echo "Starting to install prometheus"
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
useradd prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus
sudo apt-get update -y
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.2.1/prometheus-2.2.1.linux-amd64.tar.gz
tar xfz prometheus-*.tar.gz
cd prometheus-2.2.1.linux-amd64
sudo cp ./prometheus /usr/local/bin/
sudo cp ./promtool /usr/local/bin/
sudo chown -R prometheus:prometheus /usr/local/bin/prometheus
sudo chown -R prometheus:prometheus /usr/local/bin/promtool
sudo cp prometheus.yml /etc/prometheus
sudo cp -r ./consoles /etc/prometheus
sudo cp -r ./console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
sudo touch /etc/systemd/system/prometheus.service
cp /tmp/prometheous-service /etc/systemd/system/prometheus.service ##Need to have /tmp/prometheus-service 
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
}


echo "\nThis script is used to install ansible and prometheus"
echo "Type A/a for only ansible installation"
echo "Type P/p for only prometheus installation"
echo "Type B/b to install both"
echo "Type anything else to exit"
echo "-------------------------------------------------------------------------------"
read -p "Enter your choice : " INPUT_STRING
echo $INPUT_STRING
if [ "$INPUT_STRING" = "a" ] || [ "$INPUT_STRING" = "A" ]
then
echo "You Selected to install only ansible"
install_ansible

elif [ "$INPUT_STRING" = "p" ] || [ "$INPUT_STRING" = "P" ]
then
install_prometheus
echo "You choose to install Prometheous monitoring tool"
elif [ "$INPUT_STRING" = "b" ] || [ "$INPUT_STRING" = "B" ]
then
echo "You choose to install Prometheous monitoring tool ans ansible both"
install_ansible
install_prometheus
else
echo "You Select Nothing To Install"
fi
