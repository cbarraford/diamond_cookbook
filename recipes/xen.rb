# Install the xen collector config

include_recipe 'diamond::default'

collector_config 'XenCollector' do
  path  node['diamond']['collectors']['XenCollector']['path']
  owner node['diamond']['user']
  group node['diamond']['group']
end
