# Install the disk space collector config

include_recipe 'diamond::default'

collector_config 'DiskSpaceCollector' do
  perms           node['diamond']['collectors']['config_perms']
  owner           node['diamond']['owner']
  group           node['diamond']['group']
  filesystems     node['diamond']['collectors']['DiskSpaceCollector']['filesystems']
  exclude_filters node['diamond']['collectors']['DiskSpaceCollector']['exclude_filters']
  byte_unit       node['diamond']['collectors']['DiskSpaceCollector']['byte_unit']
end
