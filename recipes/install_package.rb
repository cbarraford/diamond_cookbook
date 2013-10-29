case node["platform_family"]
  when "debian"
    package "python-pysnmp4" do
      action :install
    end

    package "diamond" do
      action :install
      version node['diamond']['version']
      notifies :restart, resources(:service => "diamond")
    end

  when "redhat"
    package "diamond" do
      action :install
      version node['diamond']['version']
      notifies :restart, resources(:service => "diamond")
    end
end
