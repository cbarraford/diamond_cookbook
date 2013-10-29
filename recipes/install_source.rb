include_recipe "build-essential"

case node['platform_family']
when "debian"
  if node['platform'] == "ubuntu" && node['platform_version'].to_f < 10.10
    package "git-core"
  else
    package "git"
  end
  # needed to generate deb package
  package "devscripts"
  package "python-support"
  package "python-mock"
  package "cdbs"
else
  package "git"
  package "rpm-build"
end

# TODO: move source directory to an attribute
git node["diamond"]["source_path"] do
  repository node["diamond"]["source_repository"]
  reference node["diamond"]["source_reference"]
  action :sync
  notifies :run, "execute[build diamond]"
end

case node['platform_family']
when "debian"
  execute "build diamond" do
    command "cd #{node["diamond"]["source_path"]};make builddeb"
    action :nothing
    notifies :run, "execute[install diamond]"
  end
  
  execute "install diamond" do 
    command "cd #{node["diamond"]["source_path"]};dpkg -i build/diamond_*_all.deb"
    action :nothing
    notifies :restart, "service[diamond]"
  end
  
else
  # TODO: test this
  execute "build diamond" do
    command "cd #{node["diamond"]["source_path"]};make buildrpm"
    action :nothing
    notifies :run, "execute[install diamond]"
  end
  
  execute "install diamond" do 
    command "cd #{node["diamond"]["source_path"]};rpm -ivh dist/*.noarch.rpm"
    action :nothing
    notifies :restart, "service[diamond]"
  end
end
