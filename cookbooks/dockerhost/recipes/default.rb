#
# Cookbook Name:: dockerhost
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end

directory '/home/vagrant/myweb'

cookbook_file '/home/vagrant/myweb/Gemfile' do
  source 'Gemfile'
end

cookbook_file '/home/vagrant/myweb/index.rb' do
  source 'index.rb'
  notifies :run, 'execute[start_sinatra]', :immediately
end

execute 'start_sinatra' do
  action :nothing
  command 'sudo docker run -p 81:80 --name web1 -v /home/vagrant/myweb:/usr/src/app -e MAIN_APP_FILE=index.rb -d erikap/ruby-sinatra'
end


directory '/home/vagrant/myweb2'

cookbook_file '/home/vagrant/myweb2/Gemfile' do
  source 'Gemfile'
end

cookbook_file '/home/vagrant/myweb2/index.rb' do
  source 'index2.rb'
  notifies :run, 'execute[start_sinatra2]', :immediately
end

execute 'start_sinatra2' do
  action :nothing
  command 'sudo docker run -p 82:80 --name web2 -v /home/vagrant/myweb2:/usr/src/app -e MAIN_APP_FILE=index.rb -d erikap/ruby-sinatra'
end

directory '/home/vagrant/haproxy'

cookbook_file '/home/vagrant/haproxy/haproxy.cfg' do
  source 'haproxy.cfg'
  notifies :run, 'execute[start_haproxy]', :immediately
end

execute 'start_haproxy' do
  action :nothing
  command 'sudo docker run -d -p 80:80 --name lb1 --link web1:web1 --link web2:web2 -v /home/vagrant/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg haproxy'
end