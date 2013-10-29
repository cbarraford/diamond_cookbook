case node["platform_family"]
  when "debian"
    include_recipe "apt::default"
    
    package "python-pysnmp4" do
      action :install
    end

    package "diamond" do
      action :install
      version node['diamond']['version']
      notifies :restart, resources(:service => "diamond")
    end

  when "redhat"
    include_recipe "yum::default"
    
    package "diamond" do
      action :install
      version node['diamond']['version']
      notifies :restart, resources(:service => "diamond")
    end
end
