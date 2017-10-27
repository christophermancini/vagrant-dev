# -*- mode: ruby -*-
# vi: set ft=ruby :

# concourse box for orchestration and testing

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "concourse" do |concourse|
    concourse.vm.hostname = "concourse.vagrant-dev"

    concourse.vm.box = "bento/ubuntu-16.04"

    concourse.vm.synced_folder CODESHARE, "/home/vagrant/code", mount_options: ["dmode=777,fmode=777"]

    ##################
    # Virtualization #
    ##################
    concourse.vm.provider "virtualbox" do |v|
      v.cpus = 4
      v.memory = 4096
    end

    ##################
    #   NETWORKING   #
    ##################
    concourse.vm.network "private_network", ip: "192.168.205.10"   # IP Access
    #concourse.vm.network :forwarded_port, guest: 22, host: 2222   # SSH [DEFAULT]
    concourse.vm.network :forwarded_port, guest: 8080, host: 8080  # HTTP
    concourse.vm.network :forwarded_port, guest: 443, host: 8443   # HTTPS

    ##################
    #  PROVISIONING  #
    ##################
    concourse.vm.provision :shell, path: "provisioning/bootstrap.sh", env: {"VAGRANT_DEV_VERBOSE" => "true", "VAGRANT_DEV_BOX" => "concourse"}, args: [EXTRAVARS]
  end
end
