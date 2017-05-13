# Install the vm stat collector config

include_recipe 'diamond::default'

collector_config 'VMStatCollector' do
  owner node['diamond']['user']
  group node['diamond']['group']
end
