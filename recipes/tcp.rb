# Install the TCP collector config

include_recipe 'diamond::default'

collector_config 'TCPCollector' do
  allowed_names node['diamond']['collectors']['TCPCollector']['allowed_names']
  owner         node['diamond']['user']
  group         node['diamond']['group']
end
