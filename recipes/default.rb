# install diamond and enable basic collectors

service "diamond" do
  action [ :nothing ]
end

case node[:platform]
  when "debian", "ubuntu"
    package "python-pysnmp4" do
      action :install
    end

    package "diamond" do
      action :install
      version node['diamond']['version']
      notifies :restart, resources(:service => "diamond")
    end

  when "centos", "redhat", "fedora", "amazon", "scientific"
    package "diamond" do
      action :install
      version node['diamond']['version']
      notifies :restart, resources(:service => "diamond")
    end
end

service "diamond" do
  action [ :enable ]
end

cookbook_file "/etc/diamond/diamond.conf" do
  source "diamond.conf"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "diamond")
end

#install basic collector configs
include_recipe 'diamond::diskusage'
include_recipe 'diamond::diskspace'
include_recipe 'diamond::vmstat'
include_recipe 'diamond::memory'
include_recipe 'diamond::network'
include_recipe 'diamond::tcp'
include_recipe 'diamond::loadavg'
include_recipe 'diamond::cpu'

