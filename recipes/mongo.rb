# Install the mongo collector config

include_recipe 'diamond::default'

package 'pymongo' do
  package_name 'python-pymongo' if platform?('debian', 'ubuntu')
  action :install
end

collector_config 'MongoDBCollector' do
  perms node['diamond']['collectors']['config_perms']
  owner node['diamond']['owner']
  group node['diamond']['group']
  path  node['diamond']['collectors']['MongoDBCollector']['path']
  host  node['diamond']['collectors']['MongoDBCollector']['host']
end
