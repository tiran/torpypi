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
sudo setenforce 0
sudo dnf clean all
sudo dnf upgrade --best --allowerasing -y
sudo dnf install -y tor nginx
sudo hostnamectl set-hostname --static torpypi.python.example
sudo systemctl enable tor.service
sudo systemctl start tor.service
sudo systemctl enable nginx.service
sudo systemctl start nginx.service
        SHELL
    end

end
