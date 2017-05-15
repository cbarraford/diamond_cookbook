include_recipe 'build-essential'
include_recipe 'git::default'

case node['platform_family']
when 'debian'
  include_recipe 'apt::default'

  # needed to generate deb package
  package 'devscripts'
  if node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 16.04
    package_target = '/tmp/python-support_all.deb'
    remote_file package_target do
      source 'http://launchpadlibrarian.net/109052632/python-support_1.0.15_all.deb'
      mode 0644
      checksum '1b8498b47a08354026e7b43bb4dc42562c502e7c5def5d02b9f8837c043499f5' # SHA256
    end

    dpkg_package 'python-support' do
      source package_target
      action :install
    end
  else
    package 'python-support'
  end

  package 'python-pkg-resources'
  package 'python-configobj'
  package 'python-mock'
  package 'cdbs'
when 'rhel'
  include_recipe 'yum::default'

  package 'python-configobj'
  package 'python-setuptools'
  package 'rpm-build'
end

# TODO: move source directory to an attribute
git node['diamond']['source_path'] do
  repository node['diamond']['source_repository']
  reference node['diamond']['source_reference']
  action :sync
  notifies :run, 'execute[build diamond]', :immediately
end

case node['platform_family']
when 'debian'
  execute 'build diamond' do
    command "cd #{node['diamond']['source_path']};make builddeb"
    action :nothing
    notifies :run, 'execute[install diamond]', :immediately
  end

  execute 'install diamond' do
    command "cd #{node['diamond']['source_path']};dpkg -i build/diamond_*_all.deb"
    action :nothing
    notifies :restart, 'service[diamond]'
  end

  # The deb package includes init.d and init files
  # So that chef uses the correct provider, remove the upstart file
  # on debian since the is not an upstart system
  file '/etc/init/diamond.conf' do
    action :delete
    only_if { node['platform'] == 'debian' }
  end
else
  # TODO: test this
  execute 'build diamond' do
    command "cd #{node['diamond']['source_path']};make buildrpm"
    action :nothing
    notifies :run, 'execute[install diamond]', :immediately
  end

  execute 'install diamond' do
    command "cd #{node['diamond']['source_path']};rpm -ivh dist/*.noarch.rpm"
    action :nothing
    notifies :restart, 'service[diamond]'
  end
end
