# Install the disk space collector config

include_recipe 'diamond::default'

collector_config 'DiskUsageCollector' do
  owner            node['diamond']['owner']
  group            node['diamond']['group']
  perms node['diamond']['collectors']['config_perms']
end
