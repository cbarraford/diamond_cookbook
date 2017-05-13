# Install the disk space collector config

include_recipe 'diamond::default'

collector_config 'DiskSpaceCollector' do
  filesystems      node['diamond']['collectors']['DiskSpaceCollector']['filesystems']
  exclude_filters  node['diamond']['collectors']['DiskSpaceCollector']['exclude_filters']
  byte_unit        node['diamond']['collectors']['DiskSpaceCollector']['byte_unit']
  owner            node['diamond']['user']
  group            node['diamond']['group']
end
