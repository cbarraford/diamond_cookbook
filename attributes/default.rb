case node[:platform]
  when "ubuntu","debian"
    default[:diamond][:version] = '3.0.2'
  else
    default[:diamond][:version] = '3.0.2-0'
end

