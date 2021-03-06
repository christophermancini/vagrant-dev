# -*- mode: ruby -*-
# vi: set ft=ruby :

# main box for orchestration and testing

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "main" do |main|
    main.vm.hostname = "main.vagrant-dev"

    # Box/OS override
    #main.vm.box = "bento/ubuntu-16.04"

    main.vm.synced_folder CODESHARE, "/home/vagrant/code", mount_options: ["dmode=777,fmode=777"]

    ##################
    # Virtualization #
    ##################
    main.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 2048
    end

    ##################
    #   NETWORKING   #
    ##################
    main.vm.network "private_network", ip: "192.168.205.10"   # IP Access
    #main.vm.network :forwarded_port, guest: 22, host: 2222   # SSH [DEFAULT]
    main.vm.network :forwarded_port, guest: 80, host: 8080    # HTTP
    main.vm.network :forwarded_port, guest: 443, host: 8443   # HTTPS
    main.vm.network :forwarded_port, guest: 3306, host: 3306  # MariaDB
    main.vm.network :forwarded_port, guest: 1313, host: 1313  # HUGO

    ##################
    #  PROVISIONING  #
    ##################
    main.vm.provision :shell, path: "provisioning/bootstrap.sh", env: {"VAGRANT_DEV_VERBOSE" => "true", "VAGRANT_DEV_BOX" => "main"}, args: [EXTRAVARS]
  end
end
