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
git "/usr/local/share/diamond_src" do
  repository "git://github.com/BrightcoveOS/Diamond.git"
  action :sync
end

case node['platform_family']
when "debian"
  execute "install diamond" do
    command "cd /usr/local/share/diamond_src/;make builddeb;dpkg -i build/diamond_*_all.deb"
    not_if {File.exists?("/etc/init.d/diamond")}
  end
else
  # TODO: test this
  execute "install diamond" do
    command "cd /usr/local/share/diamond_src/;make buildrpm;rpm -ivh dist/*.noarch.rpm"
    not_if {File.exists?("/etc/init.d/diamond")}
  end
end
