title 'Diamond Core'

init_defaults = %(ENABLE_DIAMOND="yes"
DIAMOND_PID="/var/run/diamond.pid"
DIAMOND_USER="diamond"
)

describe file('/etc/diamond/diamond.conf') do
  it { should be_file }
  its(:content) { should match(/^# Diamond Configuration File$/) }
end

describe file('/etc/default/diamond') do
  it { should be_file }
  # its(:content) { should match(/^# Defaults for diamond initscript$/) }
  its(:content) { should eq init_defaults }
end

describe service('diamond') do
  it { should be_enabled }
  it { should be_running }
end
