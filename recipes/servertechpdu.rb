# install netscaler collector config

include_recipe 'diamond::default'

#load databag
databag = Chef::EncryptedDataBagItem.load("passwords", "snmp")

collector_config "ServerTechPDUCollector" do
  path      node[:diamond][:collectors][:ServerPDUCollector][:path]
  snmp      true
  interval  node[:diamond][:collectors][:ServerPDUCollector][:interval]
  timeout   node[:diamond][:collectors][:ServerPDUCollector][:timeout]
  retries   node[:diamond][:collectors][:ServerPDUCollector][:retries]
  port      node[:diamond][:collectors][:ServerPDUCollector][:port]
  community databag['community']
  devices   node[:diamond][:collectors][:ServerPDUCollector][:devices]
end
