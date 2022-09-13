# update and unzip
dpkg -s unzip &>/dev/null || {
	apt-get -y update && apt-get install -y unzip
}
 
# install consul 
cd /home/ubuntu
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install consul
unzip consul.zip
rm consul.zip
 
# make consul executable
chmod +x consul

sudo systemctl enable consul
sudo systemctl start consul
