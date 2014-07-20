#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when "centos"

	%w{httpd}.each do |pkg|
		package pkg do
			options "--enablerepo=remi"
        		action :install
		end
	end

end
