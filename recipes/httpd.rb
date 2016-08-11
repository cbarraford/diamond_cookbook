# Install the http collector config

include_recipe 'diamond::default'

collector_config 'HttpdCollector' do
  perms           node['diamond']['collectors']['config_perms']
  owner        node['diamond']['owner']
  group        node['diamond']['group']
  path         node['diamond']['collectors']['HttpdCollector']['path']
  url          node['diamond']['collectors']['HttpdCollector']['url']
end
