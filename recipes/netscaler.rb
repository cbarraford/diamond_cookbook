# Install netscaler collector config

include_recipe 'diamond::default'

# load databag
databag = Chef::EncryptedDataBagItem.load('passwords', 'snmp')

collector_config 'NetscalerSNMPCollector' do
  path      node['diamond']['collectors']['NetscalerSNMPCollector']['path']
  snmp      true
  interval  node['diamond']['collectors']['NetscalerSNMPCollector']['interval']
  timeout   node['diamond']['collectors']['NetscalerSNMPCollector']['timeout']
  retries   node['diamond']['collectors']['NetscalerSNMPCollector']['retries']
  port      node['diamond']['collectors']['NetscalerSNMPCollector']['port']
  community databag['community']
  devices   node['diamond']['collectors']['NetscalerSNMPCollector']['devices']
  owner     node['diamond']['user']
  group     node['diamond']['group']
  only_if { node['diamond']['snmp'] == 'true' }
end
