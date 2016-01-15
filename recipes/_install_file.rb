case node['platform_family']
when 'debian'
  dpkg_package 'diamond' do
    source node['diamond']['source_path']
    action :install
    version node['diamond']['version']
    notifies :restart, 'service[diamond]'
  end

when 'rhel'
  rpm_package 'diamond' do
    action :install
    source node['diamond']['source_path']
    version node['diamond']['version']
    notifies :restart, 'service[diamond]'
  end
end
