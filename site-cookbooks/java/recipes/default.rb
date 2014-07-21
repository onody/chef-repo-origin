#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when "centos"

	yum_package "java-1.7.0-openjdk-devel.x86_64" do
		action :install
	end

	execute "yum-update" do
		user "root"
		command "yum -y update"
		action :run
	end
end

