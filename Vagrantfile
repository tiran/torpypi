# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.0"

Vagrant.configure(2) do |config|
    config.vm.define "torpypi" , primary: true do |torpypi|
        torpypi.vm.box = "f23"
        torpypi.vm.box_url = "http://download.fedoraproject.org/pub/fedora/linux/releases/23/Cloud/x86_64/Images/Fedora-Cloud-Base-Vagrant-23-20151030.x86_64.vagrant-libvirt.box"
        torpypi.vm.hostname = "torpypi.python.example"

        torpypi.vm.provider :libvirt do |domain|
            domain.memory = 1024
        end

        torpypi.vm.provision "shell", inline: <<-SHELL
sudo setenforce 1
sudo dnf clean all
sudo dnf upgrade --best --allowerasing -y
sudo hostnamectl set-hostname --static torpypi.python.example

sudo chown -R root:root /vagrant/etc/
sudo chmod -R go-w /vagrant/etc/
sudo cp -av -t /etc/ /vagrant/etc/*

# install nginx and tor to create users
sudo rpm --import /vagrant/etc/pki/rpm-gpg/RPM-GPG-KEY-torproject.org.asc
sudo dnf install -y tor nginx python3-pip

sudo chmod 0600 /vagrant/var/lib/tor/python/*
sudo chown toranon:toranon /vagrant/var/lib/tor/python/*
sudo mkdir -p -m 700 /var/lib/tor/python
sudo cp -av /vagrant/var/lib/tor/python/* /var/lib/tor/python/
sudo chown -R toranon:toranon /var/lib/tor/python
sudo chmod -R go-rwx /var/lib/tor/python
sudo chcon -R system_u:object_r:tor_var_lib_t:s0 /var/lib/tor/python/

sudo restorecon -R /var/lib/tor/ /etc/

sudo systemctl enable tor.service
sudo systemctl restart tor.service
sudo systemctl enable nginx.service
sudo systemctl restart nginx.service
        SHELL
    end

end
