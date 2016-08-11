# Install the nfs collector config
include_recipe 'diamond::default'

collector_config 'NFSServerCollector' do
  owner            node['diamond']['owner']
  group            node['diamond']['group']

  path    node['diamond']['collectors']['NFSServerCollector']['path']
end
