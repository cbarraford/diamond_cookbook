package 'diamond' do
  action :install
  version node['diamond']['version']
  notifies :restart, 'service[diamond]'
end
