case node['platform_family']
  when 'debian'

    package 'python-pysnmp4' do
      action :install
    end

  package 'diamond' do
      source "#{node['diamond']['source_path']}"
      action :install
      version node['diamond']['version']
      notifies :restart, 'service[diamond]'
    end

  when 'redhat'
    include_recipe 'yum::default'

    package 'diamond' do
      action :install
      version node['diamond']['version']
      notifies :restart, 'service[diamond]'
    end
end
