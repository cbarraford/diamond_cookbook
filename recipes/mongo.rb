# Install the mongo collector config

include_recipe 'diamond::default'

package "pymongo" do
  if platform?("debian", "ubuntu")
    package_name "python-pymongo"
  end
  action :install
end

collector_config "MongoDBCollector" do
  path  node[:diamond][:collectors][:MongoDBCollector][:path]
  host  node[:diamond][:collectors][:MongoDBCollector][:host]
end
