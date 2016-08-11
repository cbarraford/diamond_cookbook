# Install the disk space collector config

include_recipe 'diamond::default'

collector_config 'CPUCollector' do
  perms           node['diamond']['collectors']['config_perms']
  owner           node['diamond']['owner']
  group           node['diamond']['group']
  percore         node['diamond']['collectors']['CPUCollector']['percore']
end
