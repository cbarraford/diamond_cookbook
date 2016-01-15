package node['diamond']['package_name'] do
  action :install
  version node['diamond']['version']
  notifies :restart, 'service[diamond]'
end
