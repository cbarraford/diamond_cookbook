# definition to add/remove diamond collector configs
define :collector_config, action: :create, enabled: 'True', snmp: false,
  owner: 'diamond', group: 'nogroup', perms: '0660' do

  if params[:action] == :create
    Chef::Log.info("Create diamond collector config: #{params[:name]}.conf")
    # params are deleted because template loops on them, creating values for
    # each in collector*.conf files
    owner = params.delete(:owner)
    group = params.delete(:group)
    perms = params.delete(:perms)
    template "/etc/diamond/collectors/#{params[:name]}.conf" do
      if params[:snmp] == false
        source 'collector_config.conf.erb'
      else
        source 'snmp_collector_config.conf.erb'
      end
      cookbook 'diamond'
      owner owner
      group group
      mode perms
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
