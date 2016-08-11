# Install the xen collector config

include_recipe 'diamond::default'

collector_config 'XenCollector' do
  owner            node['diamond']['owner']
  group            node['diamond']['group']

  path  node['diamond']['collectors']['XenCollector']['path']
end
