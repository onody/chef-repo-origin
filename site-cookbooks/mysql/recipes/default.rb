#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when "centos"

	%w{mysql-server}.each do |pkg|
		package pkg do
			options "--enablerepo=remi"
			action :install
		end
	end

	#iptables_rule "mysql"

	service "mysqld" do
		supports :status => true, :restart => true, :reload => true
		action [ :enable, :start ]
	end

end


