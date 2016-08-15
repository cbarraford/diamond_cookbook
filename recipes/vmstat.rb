# Install the vm stat collector config

include_recipe 'diamond::default'

collector_config 'VMStatCollector' do
  owner            node['diamond']['owner']
  group            node['diamond']['group']
  perms node['diamond']['collectors']['config_perms']
end
