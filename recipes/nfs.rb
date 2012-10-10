# Install the nfs collector config
include_recipe 'diamond::default'

collector_config "NFSServerCollector" do
    path    node[:diamond][:collectors][:NFSServerCollector][:path]
end
