# install diamond and enable basic collectors

service "diamond" do
  action [ :nothing ]
end

include_recipe "diamond::install_#{node['diamond']['install_method']}"

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
  notifies :restart, "service[diamond]"
  variables(
    :graphite_ip => graphite_ip
  )
end


# Install collectors
node['diamond']['add_collectors'].each do |collector|
  include_recipe "diamond::#{collector}"
end

service "diamond" do
  action [ :enable ]
end
