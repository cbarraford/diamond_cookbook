#definition to add diamond collector configs
define :collector_config, :enabled => 'True', :snmp => false do

  t = template "/etc/diamond/collectors/#{params[:name]}.conf" do
    if params[:snmp] == false
      source "collector_config.conf.erb"
    else
      source "snmp_collector_config.conf.erb"
    end
    cookbook "diamond"
    owner "root"
    group "root"
    mode "0660"
    variables(:collector_attrs => {} )
    notifies :restart, resources(:service => "diamond")
  end 

  # add collector attributes
  params.each_pair do | k,v |
    t.variables[:collector_attrs][k] = v
  end

end
