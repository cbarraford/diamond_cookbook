# install diamond and enable basic collectors

service "diamond" do
  action [ :nothing ]
end

include_recipe "diamond::install_%s" % [node['diamond']['install_method']]

service "diamond" do
  action [ :enable ]
end

if node['diamond']['graphite_server_role'].nil?
  graphite_ip = node['diamond']['graphite_server']
else
  graphite_nodes = search(:node, "role:%s" % [node['diamond']['graphite_server_role']])
  if graphite_nodes.empty?
    Chef::Log.warn("No nodes returned from search")
    graphite_ip = node['diamond']['graphite_server']
  else
    graphite_ip = graphite_nodes[0]["ipaddress"]
  end
end

template "/etc/diamond/diamond.conf" do
  source "diamond.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "diamond")
  variables(
    :graphite_ip => graphite_ip
  )
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

