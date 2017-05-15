# Install the network collector config

include_recipe 'diamond::default'

collector_config 'NetworkCollector' do
  interfaces node['diamond']['collectors']['NetworkCollector']['interfaces']
  byte_unit  node['diamond']['collectors']['NetworkCollector']['byte_unit']
  owner      node['diamond']['user']
  group      node['diamond']['group']
end
