# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define 'docker_host' do |host|
    host.vm.box = "ubuntu/trusty64"
	host.vm.network 'private_network', ip: '192.168.50.10'
	
	host.vm.provision 'chef_zero' do |chef|
	  chef.roles_path = 'roles'
	  chef.add_role 'dockerhost'
	end
  end
end
