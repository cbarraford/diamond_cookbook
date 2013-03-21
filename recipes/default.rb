# install diamond and enable basic collectors

service "diamond" do
  action [ :nothing ]
end

include_recipe "diamond::install_%s" % [node['diamond']['install_method']]

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

