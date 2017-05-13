# Install the nfs collector config
include_recipe 'diamond::default'

collector_config 'NFSServerCollector' do
  path  node['diamond']['collectors']['NFSServerCollector']['path']
  owner node['diamond']['user']
  group node['diamond']['group']
end
