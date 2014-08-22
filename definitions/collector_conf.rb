# definition to add/remove diamond collector configs
define :collector_config, action: :create, enabled: 'True', snmp: false do
  if params[:action] == :create
    Chef::Log.info("Create diamond collector config: #{params[:name]}.conf")
    template "/etc/diamond/collectors/#{params[:name]}.conf" do
      if params[:snmp] == false
        source 'collector_config.conf.erb'
      else
        source 'snmp_collector_config.conf.erb'
      end
      cookbook 'diamond'
      owner 'root'
      group 'root'
      mode '0660'
      variables(params: params)
      notifies :restart, 'service[diamond]'
    end

 elsif params[:action] == :delete
    Chef::Log.info("Deleting diamond collector config: #{params[:name]}.conf")
    file "/etc/diamond/collectors/#{params[:name]}.conf" do
      action :delete
      notifies :restart, 'service[diamond]'
    end
  end
end
