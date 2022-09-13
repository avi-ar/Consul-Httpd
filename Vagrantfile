# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.define "server" do |server|
    server.vm.box = "ubuntu/xenial64"
    server.vm.hostname = "consul-server"
    server.vm.provision "shell", path: "provision.sh"
    serverIp = "192.168.99.100"
    server.vm.network "private_network", ip: serverIp
    server.vm.provision "file", 
      source: "consul.hcl",
      destination:"/tmp/consul.hcl"
    server.vm.provision "shell",
      inline: "mv /tmp/consul.hcl /etc/consul.d/consul.hcl"
    server.vm.provision "shell", inline: "service consul start"


    server.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "Cluster"]
    end
  end

  config.vm.define "web" do |web|
    web.vm.hostname = "consul-Httpd"
    web.vm.hostname = 'web'
    web.vm.box = "ubuntu/xenial64"
    web.vm.provision "shell", path: "provision-consul-agent.sh"
    serverIPs = "192.168.99.101"
    web.vm.network "private_network", ip: serverIPs
    web.vm.provision "file", 
      source: "consul-agent.hcl",
      destination:"/tmp/consul.hcl"
    web.vm.provision "shell",
      inline: "mv /tmp/consul.hcl /etc/consul.d/consul.hcl"
    web.vm.provision "shell", inline: "service consul start"
    web.vm.provision "file", 
      source: "ports.conf",
      destination:"/tmp/ports.conf"
    web.vm.provision "shell",
      inline: "mv /tmp/ports.conf /etc/apache2/ports.conf"
    web.vm.provision "file", 
      source: "service.json",
      destination:"/home/vagrant/service.json"
    web.vm.provision "shell",
      inline: "consul services register service.json"
    web.vm.provision "shell",
      inline: "sudo systemctl restart apache2"

    web.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", 2048]
        v.customize ["modifyvm", :id, "--name", "Web"]
    end
  end
end

