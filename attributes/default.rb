default['diamond']['install_method'] = 'source'
default['diamond']['graphite_server_role'] = nil
default['diamond']['graphite_server'] = 'graphite'
default['diamond']['path_prefix'] = 'servers'
default['diamond']['interval'] = '300'
default['diamond']['handlers'] = 'diamond.handler.graphite.GraphiteHandler, diamond.handler.archive.ArchiveHandler'
default['diamond']['source_repository'] = 'git://github.com/BrightcoveOS/Diamond.git'
default['diamond']['source_path'] = '/usr/local/share/diamond_src'
default['diamond']['source_reference'] = 'master'
default['diamond']['add_collectors'] = %w(cpu diskspace diskusage loadavg memory network vmstat tcp)
case node['platform_family']
when 'debian'
  default['diamond']['version'] = '3.0.2'
when 'redhat'
  default['diamond']['version'] = '3.0.2-0'
else
  default['diamond']['install_method'] = 'source'
end
