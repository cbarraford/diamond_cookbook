maintainer       'Chad Barraford'
maintainer_email 'cbarraford@gmail.com'
license          'All rights reserved'
description      'Installs/Configures diamond'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.1.0'
name             'diamond'
issues_url       'https://github.com/CBarraford/diamond_cookbook/issues'
source_url       'https://github.com/CBarraford/diamond_cookbook'

supports         'ubuntu'
supports         'debian'
supports         'redhat'
supports         'centos'

depends          'apt'
depends          'yum'
depends          'build-essential'
depends          'git'

chef_version     '>= 12.1'
