# -*- mode: ruby -*-
# vi: set ft=ruby :

# ansible

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "ansible" do |ansible|
    ansible.vm.hostname = "ansible.vagrant-dev"

    #ansible.vm.box = "bento/ubuntu-14.04"
    #ansible.vm.box = "bento/ubuntu-16.04"

    ##################
    # Virtualization #
    ##################
    ansible.vm.provider "virtualbox" do |v|
      v.cpus = 1
      v.memory = 1024
    end

    ##################
    #   NETWORKING   #
    ##################
    ansible.vm.network "private_network", ip: "192.168.205.11"   # IP Access
    #main.vm.network :forwarded_port, guest: 22, host: 2222    # SSH [DEFAULT]

    ##################
    #  PROVISIONING  #
    ##################
    ansible.vm.provision :shell, path: "provisioning/bootstrap.sh", env: {"VAGRANT_DEV_VERBOSE" => "true", "VAGRANT_DEV_BOX" => "ansible", "VAGRANT_DEV_ANSIBLE" => "false"}, args: [EXTRAVARS]
  end
end
