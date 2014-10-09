# -*- mode: ruby -*-
# vi: set ft=ruby :
 
Vagrant.configure("2") do |config|
  # Box hosted on my server, served via VagrantCloud
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :private_network, ip: "192.168.44.14"
  config.vm.synced_folder ".", "/vagrant", :nfs => true
  config.ssh.forward_agent = true
 
  # Specific provisioner
  config.vm.provision "shell", privileged: false, path: "./_vagrant/environment.sh"
 
  config.vm.provider :virtualbox do |vb|
    vb.name = 'rubybox'
 
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id,
                  "--memory", "2048",
                  "--cpus", "4"]
  end
end
