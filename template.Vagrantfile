# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Extra variables passed into Ansible playbook as a CLI parameter
# @see http://docs.ansible.com/ansible/playbooks_variables.html#passing-variables-on-the-command-line
EXTRAVARS = ENV['EXTRA_VARS'] || "@/vagrant/extra_vars.json"

# CODESHARE is the directory where you checkout all your code that you want accessible from the guest VMs
CODESHARE = "../code/"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Base Vagrant boxes from Chef
  # @see https://github.com/chef/bento#bento
  config.vm.box = "bento/ubuntu-14.04"
  #config.vm.box = "bento/ubuntu-16.04"
  #config.vm.box = "bento/centos-6.7"
  #config.vm.box = "bento/centos-7.2"
  #config.vm.box = "bento/debian-7.8"
  #config.vm.box = "bento/debian-8.5"
end

# This section makes it easier to spin up different environment configurations
vagrantfiles = %w[vagrant/Vagrantfile.main]

# Iterate over the vagrantfiles list and load each vagrant file
vagrantfiles.each do |vagrantfile|
  load File.expand_path(vagrantfile) if File.exists?(vagrantfile)
end
