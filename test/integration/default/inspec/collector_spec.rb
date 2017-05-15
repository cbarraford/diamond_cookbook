title 'Diamond Collectors'

%w(
  CPUCollector
  MemoryCollector
  DiskSpaceCollector
).each do |collector|
  describe file("/etc/diamond/collectors/#{collector}.conf") do
    it { should be_file }
    its(:content) { should match(/^### Options for #{collector}$/) }
    its(:content) { should match(/^enabled = True$/) }
  end
end
