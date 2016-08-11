# Install the varnish collector config

include_recipe 'diamond::default'

collector_config 'VarnishCollector' do
  owner            node['diamond']['owner']
  group            node['diamond']['group']

  path  node['diamond']['collectors']['VarnishCollector']['path']
end
