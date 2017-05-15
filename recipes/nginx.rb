# Install the nginx collector config

include_recipe 'diamond::default'

collector_config 'NginxCollector' do
  path      node['diamond']['collectors']['NginxCollector']['path']
  req_host  node['diamond']['collectors']['NginxCollector']['req_host']
  req_port  node['diamond']['collectors']['NginxCollector']['req_port']
  req_path  node['diamond']['collectors']['NginxCollector']['req_path']
  owner     node['diamond']['user']
  group     node['diamond']['group']
end
