default["diamond"]["install_method"] = "package"
default["diamond"]["graphite_server_role"] = nil
default["diamond"]["graphite_server"] = "graphite"
default["diamond"]["handlers"] = "diamond.handler.graphite.GraphiteHandler, diamond.handler.archive.ArchiveHandler"
case node[:platform]
  when "ubuntu","debian"
    default[:diamond][:version] = '3.0.2'
  else
    default[:diamond][:version] = '3.0.2-0'
end
