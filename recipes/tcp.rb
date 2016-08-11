# Install the TCP collector config

include_recipe 'diamond::default'

collector_config 'TCPCollector' do
  owner            node['diamond']['owner']
  group            node['diamond']['group']
  perms           node['diamond']['collectors']['config_perms']
  allowed_names node['diamond']['collectors']['TCPCollector']['allowed_names']
end
