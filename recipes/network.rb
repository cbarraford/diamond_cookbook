# Install the network collector config

include_recipe 'diamond::default'

collector_config 'NetworkCollector' do
  owner            node['diamond']['owner']
  group            node['diamond']['group']
  perms           node['diamond']['collectors']['config_perms']
  interfaces node['diamond']['collectors']['NetworkCollector']['interfaces']
  byte_unit node['diamond']['collectors']['NetworkCollector']['byte_unit']
end
