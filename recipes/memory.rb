# Install the memory collector config

include_recipe 'diamond::default'

collector_config 'MemoryCollector' do
  owner node['diamond']['user']
  group node['diamond']['group']
end
