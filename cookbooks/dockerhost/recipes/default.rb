#
# Cookbook Name:: dockerhost
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end

webserver_count = 2

1.upto(webserver_count) do |count|
  directory "/home/vagrant/myweb#{count}"
  
  cookbook_file "/home/vagrant/myweb#{count}/Gemfile" do
    source 'Gemfile'
  end

  cookbook_file "/home/vagrant/myweb#{count}/index.rb" do
    source "index#{count}.rb"
    notifies :run, "execute[start_sinatra#{count}]", :immediately
  end

  execute "start_sinatra#{count}" do
    action :nothing
    command "sudo docker run -p 8#{count}:80 --name web#{count} -v /home/vagrant/myweb#{count}:/usr/src/app -e MAIN_APP_FILE=index.rb -d erikap/ruby-sinatra"
  end
end


directory '/home/vagrant/haproxy'

cookbook_file '/home/vagrant/haproxy/haproxy.cfg' do
  source 'haproxy.cfg'
  notifies :run, 'execute[start_haproxy]', :immediately
end

haproxy_docker_cmd = "sudo docker run -d -p 80:80 --name lb1 "
1.upto(webserver_count) do |count|
  haproxy_docker_cmd << "--link web#{count}:web#{count} "
end

haproxy_docker_cmd << '-v /home/vagrant/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg haproxy'

execute 'start_haproxy' do
  action :nothing
  command haproxy_docker_cmd
end


