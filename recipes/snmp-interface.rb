# install snmp interface collector config

include_recipe 'diamond::default'

package 'python-pysnmp4' do
  action :install
end

# load databag
databag = Chef::EncryptedDataBagItem.load('passwords', 'snmp')

collector_config 'SNMPInterfaceCollector' do
  path      node['diamond']['collectors']['SNMPInterfaceCollector']['path']
  snmp      true
  interval  node['diamond']['collectors']['SNMPInterfaceCollector']['interval']
  timeout   node['diamond']['collectors']['SNMPInterfaceCollector']['timeout']
  retries   node['diamond']['collectors']['SNMPInterfaceCollector']['retries']
  port      node['diamond']['collectors']['SNMPInterfaceCollector']['port']
  community databag['community']
  devices   node['diamond']['collectors']['SNMPInterfaceCollector']['devices']
  owner     node['diamond']['user']
  group     node['diamond']['group']
end
