# Install the mysql collector config

include_recipe 'diamond::default'

# load data bag
mysql = Chef::EncryptedDataBagItem.load('passwords', 'mysql')

collector_config 'MySQLCollector' do
  path    node['diamond']['collectors']['MySQLCollector']['path']
  host    node['diamond']['collectors']['MySQLCollector']['host']
  port    node['diamond']['collectors']['MySQLCollector']['port']
  db      node['diamond']['collectors']['MySQLCollector']['db']
  user    mysql['username']
  passwd  mysql['password']
  owner   node['diamond']['user']
  group   node['diamond']['group']
end
