# Install the varnish collector config

include_recipe 'diamond::default'

collector_config "VarnishCollector" do
  path  node[:diamond][:collectors][:VarnishCollector][:path]
end
