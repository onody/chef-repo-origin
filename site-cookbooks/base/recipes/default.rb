#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# timezone
if ['rhel','centos','scientific','amazon'].member? node[:platform]
	#package "tzdata"
	link "/etc/localtime" do
		to "/usr/share/zoneinfo/Japan"
	end
end

# hosts
template "/etc/hostname" do
        source "hostname.erb"
        owner "root"
        group "root"
        mode 0644
        variables({
                :hostname => node[:host_name]
        })
end
template "/etc/hosts" do
        source "hosts.erb"
        owner "root"
        group "root"
        mode 0644
        variables({
		:hostname => node[:host_name]
		#:ip_address => node[:ip_address]
        })
end

# rootログイン禁止


# utility
%w{zsh vim ntp wget}.each do |pkg|
	package pkg do
		action :install
	end
end

