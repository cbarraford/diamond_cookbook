# Install the load average collector config

include_recipe 'diamond::default'

collector_config 'LoadAverageCollector' do
  owner node['diamond']['user']
  group node['diamond']['group']
end
