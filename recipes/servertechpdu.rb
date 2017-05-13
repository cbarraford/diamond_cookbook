# install netscaler collector config

include_recipe 'diamond::default'

# load databag
databag = Chef::EncryptedDataBagItem.load('passwords', 'snmp')

collector_config 'ServerTechPDUCollector' do
  path      node['diamond']['collectors']['ServerTechPDUCollector']['path']
  snmp      true
  interval  node['diamond']['collectors']['ServerTechPDUCollector']['interval']
  timeout   node['diamond']['collectors']['ServerTechPDUCollector']['timeout']
  retries   node['diamond']['collectors']['ServerTechPDUCollector']['retries']
  port      node['diamond']['collectors']['ServerTechPDUCollector']['port']
  community databag['community']
  devices   node['diamond']['collectors']['ServerTechPDUCollector']['devices']
  owner     node['diamond']['user']
  group     node['diamond']['group']
end
