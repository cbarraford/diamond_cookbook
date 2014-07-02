# Install the mongo collector config

include_recipe 'diamond::default'

package 'pymongo' do
  package_name 'python-pymongo' if platform?('debian', 'ubuntu')
  end
  action :install
end

collector_config 'MongoDBCollector' do
  path  node[:diamond][:collectors][:MongoDBCollector][:path]
  host  node[:diamond][:collectors][:MongoDBCollector][:host]
end
