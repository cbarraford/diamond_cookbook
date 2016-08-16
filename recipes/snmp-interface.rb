# install snmp interface collector config

include_recipe 'diamond::default'

package 'python-pysnmp4' do
  action :install
end

# load databag
databag = Chef::EncryptedDataBagItem.load('passwords', 'snmp')

collector_config 'SNMPInterfaceCollector' do
  owner            node['diamond']['owner']
  group            node['diamond']['group']
  perms node['diamond']['collectors']['config_perms']
  path      node['diamond']['collectors']['SNMPInterfaceCollector']['path']
  snmp      true
  interval  node['diamond']['collectors']['SNMPInterfaceCollector']['interval']
  timeout   node['diamond']['collectors']['SNMPInterfaceCollector']['timeout']
  retries   node['diamond']['collectors']['SNMPInterfaceCollector']['retries']
  port      node['diamond']['collectors']['SNMPInterfaceCollector']['port']
  community databag['community']
  devices   node['diamond']['collectors']['SNMPInterfaceCollector']['devices']
end
