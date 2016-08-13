require 'serverspec'

# Required by serverspec
set :backend, :exec

describe "Diamond Cookbook" do

  files = %w[/etc/diamond/diamond.conf /etc/default/diamond]
  files.each do |f|
    describe file(f) do
      it { should be_file }
    end
  end

  collectors = %w[ CPUCollector MemoryCollector DiskSpaceCollector ]

  collectors.each  do |collector|
    describe file("/etc/diamond/collectors/#{collector}.conf") do
      it { should be_file }
    end
  end

end
