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
end

execute 'start_sinatra' do
  command 'sudo docker run -p 80:80 -v /home/vagrant/myweb:/usr/src/app -e MAIN_APP_FILE=index.rb -d erikap/ruby-sinatra'
end


directory '/home/vagrant/myweb2'

cookbook_file '/home/vagrant/myweb2/Gemfile' do
  source 'Gemfile'
end

cookbook_file '/home/vagrant/myweb2/index.rb' do
  source 'index2.rb'
end

execute 'start_sinatra' do
  command 'sudo docker run -p 81:80 -v /home/vagrant/myweb2:/usr/src/app -e MAIN_APP_FILE=index.rb -d erikap/ruby-sinatra'
end