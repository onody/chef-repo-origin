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


# utility
%w{zsh vim ntp wget}.each do |pkg|
	package pkg do
		action :install
	end
end

# add the EPEL repo
yum_repository 'epel' do
  description 'Extra Packages for Enterprise Linux'
  mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
  fastestmirror_enabled true
  gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
  action :create
end

# add the Remi repo
yum_repository 'remi' do
  description 'Les RPM de Remi - Repository'
  baseurl 'http://rpms.famillecollet.com/enterprise/6/remi/x86_64/'
  gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
  fastestmirror_enabled true
  action :create
end

# add users

data_ids = data_bag('users')
data_ids.each do |id|
	u = data_bag_item('users', id)
	user u['id'] do
		shell    u['shell']
		password u['password']
		supports :manage_home => true, :non_unique => false
		action   [:create]
	end
end

group 'samplegroup' do
	group_name 'samplegroup'
	members    ['onodera']
	action     [:create]
end



