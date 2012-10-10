# Install the http collector config

include_recipe 'diamond::default'

collector_config "HttpdCollector" do
  path         node[:diamond][:collectors][:HttpdCollector][:path]
  url          node[:diamond][:collectors][:HttpdCollector][:url]
end

