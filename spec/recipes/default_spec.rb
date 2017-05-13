require 'spec_helper'

describe 'diamond::default' do
  shared_examples_for 'default collector configs' do
    it 'create "/etc/diamond/collectors/CPUCollector.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/collectors/CPUCollector.conf').with(
        source: 'collector_config.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0660',
        variables: {
          params: {
            action: :create,
            enabled: 'True',
            snmp: false,
            name: 'CPUCollector',
          },
        }
      )
    end

    it 'create "/etc/diamond/collectors/DiskSpaceCollector.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/collectors/DiskSpaceCollector.conf').with(
        source: 'collector_config.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0660',
        variables: {
          params: {
            action: :create,
            enabled: 'True',
            snmp: false,
            filesystems: %w(
              ext2
              ext3
              ext4
              xfs
              glusterfs
              nfs
              ntfs
              hfs
              fat32
              fat16
            ).join(', '),
            exclude_filters: '/export/home',
            byte_unit: 'byte',
            name: 'DiskSpaceCollector',
          },
        }
      )
    end

    it 'create "/etc/diamond/collectors/DiskUsageCollector.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/collectors/DiskUsageCollector.conf').with(
        source: 'collector_config.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0660',
        variables: {
          params: {
            action: :create,
            enabled: 'True',
            snmp: false,
            name: 'DiskUsageCollector',
          },
        }
      )
    end

    it 'create "/etc/diamond/collectors/LoadAverageCollector.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/collectors/LoadAverageCollector.conf').with(
        source: 'collector_config.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0660',
        variables: {
          params: {
            action: :create,
            enabled: 'True',
            snmp: false,
            name: 'LoadAverageCollector',
          },
        }
      )
    end

    it 'create "/etc/diamond/collectors/MemoryCollector.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/collectors/MemoryCollector.conf').with(
        source: 'collector_config.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0660',
        variables: {
          params: {
            action: :create,
            enabled: 'True',
            snmp: false,
            name: 'MemoryCollector',
          },
        }
      )
    end

    it 'create "/etc/diamond/collectors/NetworkCollector.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/collectors/NetworkCollector.conf').with(
        source: 'collector_config.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0660',
        variables: {
          params: {
            action: :create,
            enabled: 'True',
            snmp: false,
            interfaces: 'eth,pbond,bond',
            byte_unit: 'megabit',
            name: 'NetworkCollector',
          },
        }
      )
    end

    it 'create "/etc/diamond/collectors/VMStatCollector.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/collectors/VMStatCollector.conf').with(
        source: 'collector_config.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0660',
        variables: {
          params: {
            action: :create,
            enabled: 'True',
            snmp: false,
            name: 'VMStatCollector',
          },
        }
      )
    end

    it 'create "/etc/diamond/collectors/TCPCollector.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/collectors/TCPCollector.conf').with(
        source: 'collector_config.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0660',
        variables: {
          params: {
            action: :create,
            enabled: 'True',
            snmp: false,
            allowed_names: %w(
              ListenOverflows
              ListenDrops
              TCPLoss
              TCPTimeouts
              TCPFastRetrans
              TCPLostRetransmit
              TCPForwardRetrans
              TCPSlowStartRetrans
              CurrEstab
              TCPAbortOnMemory
              TCPBacklogDrop
              AttemptFails
              EstabResets
              InErrs
              ActiveOpens
              PassiveOpens
            ).join(', '),
            name: 'TCPCollector',
          },
        }
      )
    end
  end

  shared_examples_for 'diamond config and service' do
    it 'create "/etc/diamond/diamond.conf" template' do
      expect(chef_run).to create_template('/etc/diamond/diamond.conf').with(
        source: 'diamond.conf.erb',
        owner: 'diamond',
        group: file_owner,
        mode: '0644',
        variables: {
          graphite_ip: 'graphite',
          graphite_pickle_port: '2004',
          graphite_port: '2003',
          statsd_host: 'localhost',
          statsd_port: '8125',
        }
      )
    end

    it 'enable "diamond" service' do
      expect(chef_run).to enable_service('diamond')
    end
  end

  shared_examples_for 'install from source: sync and build' do
    it 'clone "/usr/local/share/diamond_src" repo' do
      expect(chef_run).to sync_git('/usr/local/share/diamond_src').with(
        repository: 'git://github.com/python-diamond/Diamond.git',
        reference: 'master'
      )
      resource = chef_run.git('/usr/local/share/diamond_src')
      expect(resource).to notify('execute[build diamond]').to(:run).immediately
    end

    it 'not run "build diamond" execute' do
      expect(chef_run).to_not run_execute('build diamond')
      resource = chef_run.execute('build diamond')
      expect(resource).to notify('execute[install diamond]').to(:run).immediately
    end

    it 'not run "install diamond" execute' do
      expect(chef_run).to_not run_execute('install diamond')
    end
  end

  shared_examples_for 'install from source: Debian family' do
    it 'install "devscripts" package' do
      expect(chef_run).to install_package('devscripts')
    end

    it 'install "python-configobj" package' do
      expect(chef_run).to install_package('python-configobj')
    end

    it 'install "python-mock" package' do
      expect(chef_run).to install_package('python-mock')
    end

    it 'install "cdbs" package' do
      expect(chef_run).to install_package('cdbs')
    end
  end

  shared_examples_for 'install from source: RHEL family' do
    it 'install "python-configobj" package' do
      expect(chef_run).to install_package('python-configobj')
    end

    it 'install "python-setuptools" package' do
      expect(chef_run).to install_package('python-setuptools')
    end

    it 'install "rpm-build" package' do
      expect(chef_run).to install_package('rpm-build')
    end
  end

  context 'with default node attributes' do
    context 'CentOS' do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge(described_recipe) }

      it_behaves_like 'diamond config and service' do
        let(:file_owner) { 'nobody' }
      end

      it_behaves_like 'default collector configs' do
        let(:file_owner) { 'nobody' }
      end

      it_behaves_like 'install from source: sync and build'
      it_behaves_like 'install from source: RHEL family'

      it 'create "/etc/default/diamond" template' do
        expect(chef_run).to create_template('/etc/default/diamond').with(
          source: 'diamond-env.erb',
          owner: 'diamond',
          group: 'nobody',
          mode: '0644'
        )
      end
    end
  end

  context 'with default node attributes' do
    context 'Debian' do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'debian', version: '8.7').converge(described_recipe) }

      it_behaves_like 'diamond config and service' do
        let(:file_owner) { 'nogroup' }
      end

      it_behaves_like 'default collector configs' do
        let(:file_owner) { 'nogroup' }
      end

      it_behaves_like 'install from source: sync and build'
      it_behaves_like 'install from source: Debian family'

      it 'install "python-support" package' do
        expect(chef_run).to install_package('python-support')
      end

      it 'install "python-pkg-resources" package' do
        expect(chef_run).to install_package('python-pkg-resources')
      end

      it 'create "/etc/default/diamond" template' do
        expect(chef_run).to create_template('/etc/default/diamond').with(
          source: 'diamond-env.erb',
          owner: 'diamond',
          group: 'nogroup',
          mode: '0644'
        )
      end
    end
  end

  context 'with default node attributes' do
    context 'Ubuntu 14.04' do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

      it_behaves_like 'diamond config and service' do
        let(:file_owner) { 'nogroup' }
      end

      it_behaves_like 'default collector configs' do
        let(:file_owner) { 'nogroup' }
      end

      it_behaves_like 'install from source: sync and build'
      it_behaves_like 'install from source: Debian family'

      it 'install "python-support" package' do
        expect(chef_run).to install_package('python-support')
      end

      it 'create "/etc/default/diamond" template' do
        expect(chef_run).to create_template('/etc/default/diamond').with(
          source: 'diamond-env.erb',
          owner: 'diamond',
          group: 'nogroup',
          mode: '0644'
        )
      end
    end

    context 'Ubuntu 16.04' do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

      it_behaves_like 'diamond config and service' do
        let(:file_owner) { 'nogroup' }
      end

      it_behaves_like 'default collector configs' do
        let(:file_owner) { 'nogroup' }
      end

      it_behaves_like 'install from source: sync and build'
      it_behaves_like 'install from source: Debian family'

      it 'create "/tmp/python-support_all.deb" file' do
        expect(chef_run).to create_remote_file('/tmp/python-support_all.deb').with(
          source: 'http://launchpadlibrarian.net/109052632/python-support_1.0.15_all.deb',
          mode: 0644,
          checksum: '1b8498b47a08354026e7b43bb4dc42562c502e7c5def5d02b9f8837c043499f5'
        )
      end

      it 'install "python-support" package' do
        expect(chef_run).to install_dpkg_package('python-support')
      end

      it 'create "/etc/default/diamond" template' do
        expect(chef_run).to create_template('/etc/default/diamond').with(
          source: 'diamond-env.erb',
          owner: 'diamond',
          group: 'nogroup',
          mode: '0644'
        )
      end
    end
  end
end
