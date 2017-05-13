# Install the disk space collector config

include_recipe 'diamond::default'

collector_config 'DiskUsageCollector' do
  owner node['diamond']['user']
  group node['diamond']['group']
end
