#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when "centos"

	%w{php php-pear php-mbstring php-xml php-devel php-mysql php-gd}.each do |pkg|
	    package pkg do
	        options "--enablerepo=remi"
	        action :install
	    end
	end

end
