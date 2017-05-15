# Install the mongo collector config

include_recipe 'diamond::default'

package 'pymongo' do
  package_name 'python-pymongo' if platform?('debian', 'ubuntu')
  action :install
end

collector_config 'MongoDBCollector' do
  path  node['diamond']['collectors']['MongoDBCollector']['path']
  host  node['diamond']['collectors']['MongoDBCollector']['host']
  owner node['diamond']['user']
  group node['diamond']['group']
end
