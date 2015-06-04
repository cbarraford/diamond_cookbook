# install diamond and enable basic collectors

service 'diamond' do
  action [:nothing]
end

include_recipe "diamond::install_#{node['diamond']['install_method']}"

if node['diamond']['graphite_server_role'].nil?
  graphite_ip = node['diamond']['graphite_server']
else
  if Chef::Config[:solo]
    Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
  else
    graphite_nodes = search(:node, "role:#{node['diamond']['graphite_server_role']}")
    if graphite_nodes.empty?
      Chef::Log.warn('No nodes returned from search')
      graphite_ip = node['diamond']['graphite_server']
    else
      graphite_ip = graphite_nodes[0]['fqdn']
    end
  end
end

template '/etc/diamond/diamond.conf' do
  source 'diamond.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[diamond]'
  variables(
    graphite_ip: graphite_ip,
    graphite_port: node['diamond']['graphite_port'],
    graphite_pickle_port: node['diamond']['graphite_pickle_port']
  )
end

# Install collectors
node['diamond']['add_collectors'].each do |collector|
  include_recipe "diamond::#{collector}"
end

service 'diamond' do
  action [:enable]
end
