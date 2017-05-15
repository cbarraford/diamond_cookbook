# Install the haproxy collector config

include_recipe 'diamond::default'

# load the data bag
databag = Chef::EncryptedDataBagItem.load('passwords', 'haproxy')

collector_config 'HAProxyCollector' do
  path         node['diamond']['collectors']['HAProxyCollector']['path']
  stats_uri    node['diamond']['collectors']['HAProxyCollector']['stats_uri']
  stats_user   databag['standard']['stats_user']
  stats_pass   databag['standard']['stats_pass']
  owner        node['diamond']['user']
  group        node['diamond']['group']
end
